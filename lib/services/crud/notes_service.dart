/*
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myprivatenotes/extensions/list/filter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'show join;
import 'package:path_provider/path_provider.dart'show getApplicationDocumentsDirectory, MissingPlatformDirectoryException;
import 'package:myprivatenotes/services/crud/crud_exceptions.dart';
import 'package:myprivatenotes/extensions/list/filter.dart';

class NotesService {
  Database? _db;

  List<DatabaseNote> _notes = [];
  DatabaseUser ? _user;
  static final NotesService _shared = NotesService._sharedInstance();
  NotesService._sharedInstance(){
    _notesStreamController = StreamController<List<DatabaseNote>>.broadcast(
      onListen: () {
        _notesStreamController.sink.add(_notes);
      },
    );
  }
  factory NotesService() => _shared;

 late final  StreamController<List<DatabaseNote>> _notesStreamController ;
  Database _getDatabaseOrThrow(){
    final db = _db;
    if(db ==null){
      throw DatabaseIsNotOpen();
    }else{
      return db;
    }


  }
  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyInOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path,dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      //create User table
      await db.execute(createUserTable);
      //create note table
      await db.execute(createNoteTable);
      print('Database opened at $dbPath');

      await _cacheNotes();
    }on MissingPlatformDirectoryException{
     throw UnableToGetDocumentDirectory();
    }
  }
  Future<void> _ensureDbIsOpen() async {
    try{
      await open();
    }on DatabaseAlreadyInOpenException{

    }

  }
  Future<void> close() async{
    final db =_db;
    if (db == null){
      throw DatabaseIsNotOpen();
    }else{
      await db.close();
      _db= null;
    }
  }
  Future<void> deleteUser({required String email}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if(deletedCount != 1){
      throw CouldNotDeleteUser();
    }
  }
  Future<DatabaseUser> createUser ({required String email}) async{
    await _ensureDbIsOpen();
    final db =_getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if(results.isNotEmpty){
      throw UserAlreadyExists();
    }
    final userId = await db.insert(userTable, {
      emailColumn: email.toLowerCase(),

    });
    return DatabaseUser(id: userId, email: email);
  }
  Future<DatabaseUser> getUser ({required String email}) async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isEmpty){
      throw CouldNotFindUser();
    }else{
      return DatabaseUser.fromRow(results.first);
    }
  }
  Future<DatabaseNote> createNote({required DatabaseUser owner }) async{
    await _ensureDbIsOpen();
    final db =_getDatabaseOrThrow();
    //make sure owner exists in the database with the correct ID
    final dbUser = await getUser(email: owner.email);
    if(dbUser !=owner){
      throw CouldNotFindUser();
    }
    const text = '';
    //create the note
    final noteId = await db.insert(noteTable, {
      userIdColumn: owner.id,
      textColumn: text,
      isSyncedWithCloudColumn: 1,
    });
    final note = DatabaseNote(
         id: noteId,
         userId: owner.id,
         text: text,
         isSyncedWithCloud: true,
    );
    _notes.add(note);
    _notesStreamController.add(_notes);
    return note;
  }
  Future<void> deleteNote({required int id}) async {
    await _ensureDbIsOpen();
    final db =_getDatabaseOrThrow();
    final deletedCount = await db.delete(
      noteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (deletedCount == 0 ){
      throw CouldNotDeleteNote();
    }else{
      _notes.removeWhere((note) => note.id == id);
      _notesStreamController.add(_notes);
    }

  }
  Future<int> deleteAllNotes() async {
    await _ensureDbIsOpen();
    final db =_getDatabaseOrThrow();
    final numberOfDeletions =  await db.delete(noteTable);
    _notes = [];
    _notesStreamController.add(_notes);
    return numberOfDeletions;
  }
  Future<DatabaseNote> getNote({required int id }) async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final notes = await db.query(
      noteTable,
      limit: 1,
      where: 'id = ?',
      whereArgs: [id],
    );
    if(notes.isEmpty){
      throw CouldNotFindNotes();
    }else{
      final note = DatabaseNote.fromRow(notes.first);
      _notes.removeWhere((note) => note.id == id);
      _notes.add(note);
      _notesStreamController.add(_notes);
      return note;
    }
    

  }
  Future<Iterable<DatabaseNote>> getAllNotes() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final notes = await db.query(
      noteTable,
    );
    return notes.map((noteRow) => DatabaseNote.fromRow(noteRow));
  }
  Future<DatabaseNote> updateNotes ({
    required DatabaseNote note,
    required String text,
}) async
  {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    //make sure note exists
    await getNote(id: note.id);
    //update DB
    final updatesCount = await db.update(noteTable, {
      textColumn: text,
      isSyncedWithCloudColumn : 0,
    } , where:  'id = ?',
      whereArgs: [note.id],
    );


    if(updatesCount == 0){
      throw CouldNotUpdateNotes();
    }else {

      final updatedNote = await getNote(id: note.id);
      _notes.removeWhere((note) => note.id == updatedNote.id);
      _notes.add(updatedNote);
      _notesStreamController.add(_notes);
      return updatedNote;
    }
  }
  Future<void> _cacheNotes() async {
    final allNotes = await getAllNotes();
    _notes = allNotes.toList();
    _notesStreamController.add(_notes);
  }
  Future<DatabaseUser> getOrCreateUser({
    required String email,
    bool setAsCurrentUser = true,
  }) async
  {
    try{
      final user = await getUser(email: email);
      if (setAsCurrentUser) {
        _user = user;
      }
      return user;

    }on CouldNotFindUser {
      final createdUser = await createUser(email: email);
      if( setAsCurrentUser) {
        _user = createdUser;
      }
      return createdUser;

    } catch (e){
      rethrow;
    }
  }
  Stream<List<DatabaseNote>> get allNotes =>
      _notesStreamController.stream.filter((note){
        final currentUser = _user;
        if (currentUser == null) {
          throw UserShouldBeSetBeforeReadingAllNotes();
        } else {
          return note.userId == currentUser.id;
        }
      });
}

@immutable
class DatabaseUser{
  final int id;
  final String email;
  const DatabaseUser({
    required this.id,
    required this.email,
  });
  DatabaseUser.fromRow(Map<String,Object?> map)
      : id = map[idColumn]as int,
        email= map[emailColumn]as String;

  @override
  String toString()=> 'Person, ID = $id, email = $email';

  @override
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

}
class DatabaseNote{
  final int id;
  final int userId;
  final String text;
  final bool isSyncedWithCloud;

  DatabaseNote({
    required this.id,
    required this.userId,
    required this.text,
    required this.isSyncedWithCloud,
  });
  DatabaseNote.fromRow(Map<String,Object?> map)
      : id = map[idColumn]as int,
        userId = map[userIdColumn] as int,
        text = map[textColumn] as String,
        isSyncedWithCloud = (map[isSyncedWithCloudColumn] as int) == 1 ? true : false ;
  @override
  String toString() =>
      'Note , ID =$id, userId = $userId,isSyncedWithCloud = $isSyncedWithCloud';

  @override
  bool operator ==(covariant DatabaseNote other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

}

const dbName = 'notes.db';
const noteTable = 'note';
const userTable = 'user';
const idColumn = 'id';
const emailColumn = 'email';
const userIdColumn = 'user_id';
const textColumn ='text';
const isSyncedWithCloudColumn = 'is_synced_with_cloud';
const createUserTable =
''' CREATE TABLE IF NOT EXISTS "user" (
         	"id"	INTEGER NOT NULL,
	        "email"	TEXT NOT NULL UNIQUE,
	        PRIMARY KEY("id" AUTOINCREMENT)
          );  
      ''';
const createNoteTable =
''' CREATE TABLE IF NOT EXISTS "note" ( "id"	INTEGER NOT NULL,
	        "user_id"	INTEGER,
	        "text"	TEXT,
	        "is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
	        PRIMARY KEY("id" AUTOINCREMENT),
        	FOREIGN KEY("user_id") REFERENCES "user"("id")
          ); ''';*/
