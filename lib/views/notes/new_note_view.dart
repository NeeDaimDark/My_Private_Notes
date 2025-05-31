import 'package:flutter/material.dart';
import 'package:myprivatenotes/services/auth/auth_service.dart';
import 'package:myprivatenotes/services/crud/notes_service.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({super.key});

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  DatabaseNote? _note;
  late final NotesService _notesService;
  late final TextEditingController _textController;
  bool _isInitialized = false; // Pour éviter de réinitialiser plusieurs fois

  @override
  void initState() {
    _notesService = NotesService();
    _textController = TextEditingController();
    super.initState();
  }

  Future<void> _setupNote() async {
    if (_isInitialized) return;
    final currentUser = AuthService.firebase().currentUser!;
    final owner = await _notesService.getUser(email: currentUser.email!);
    _note = await _notesService.createNote(owner: owner);
    _textController.text = _note?.text ?? '';
    _textController.addListener(_textControllerListener);
    _isInitialized = true;
  }

  void _textControllerListener() {
    final note = _note;
    if (note == null) return;
    final text = _textController.text;
    // Sauvegarde automatique à chaque modification
    _notesService.updateNotes(note: note, text: text);
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _notesService.deleteNote(id: note.id);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty) {
      await _notesService.updateNotes(note: note, text: text);
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _textController.removeListener(_textControllerListener);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _setupNote(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && _isInitialized) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text('New Note'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Type your note here...',
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
