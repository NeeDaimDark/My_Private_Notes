# 📱 Nuvio – Secure Notes App

**Nuvio** est une application mobile de prise de notes confidentielle et sécurisée. Pensée pour l'utilisateur moderne, elle permet de rédiger, organiser et gérer ses notes personnelles en toute sérénité, avec une authentification sécurisée et un design fluide.

---

## ✨ Fonctionnalités clés

- 🔐 **Authentification par e-mail** avec vérification et réinitialisation du mot de passe
- 📝 **CRUD des notes** : création, lecture, modification, suppression
- ☁️ **Stockage cloud sécurisé** avec Firestore
- 👤 **Notes utilisateur privées** (uniquement visibles par leur créateur)
- 🔄 **Synchronisation en temps réel**
- 🧭 **Navigation fluide** avec gestion des routes
- 🌍 **Localisation complète en trois langues** :
    - 🇬🇧 Anglais
    - 🇫🇷 Français
    - 🇪🇸 Espagnol
- 📱 **UI moderne** avec écran de démarrage, icône personnalisée et messages d'erreur adaptés
- 🧠 **Gestion d'état avancée** avec le pattern **Bloc**

---

## 🗂️ Structure du projet

```My_Private_Notes/
├── android/              # Configuration Android
├── ios/                  # Configuration iOS
├──   lib/
├──── constants/            # Constantes globales
├────  enums/                # Enums utilisés dans l’app
├────  extensions/           # Extensions Dart personnalisées
├────  helpers/              # Aides utilitaires (ex. loading, context extensions)
├────  l10n/                 # Fichiers de traduction (intl)
├────  services/
│   ├────  auth/             # Authentification Firebase (Bloc, provider, etc.)
│   ├────  cloud/            # Gestion des notes Firestore
│   └────  crud/             # Ancien CRUD local (SQLite)
├────  utilities/
│   └────  dialogs/          # Dialogues personnalisés (erreurs, confirm, etc.)
├────  views/                # Écrans de l'application
└────  main.dart             # Point d’entrée de l'application
```
## 🌐 Localisation
- Toutes les vues, dialogues, messages d'erreur, écrans de chargement, et confirmations sont traduits intégralement en :

-- en English

-- 🇫🇷 Français

-- 🇪🇸 Español

-Chaque langue est automatiquement détectée et peut être changée dynamiquement depuis l’application.

## ⚙️ Technologies utilisées
- Flutter (Dart)

- Firebase Auth & Firestore

- Bloc (flutter_bloc)

- SQLite (ancien système de persistance local)

- Internationalization (intl & .arb files)

## 🚀 Lancer l'application:
1. Clonez le dépôt : `git clone https://github.com/NeeDaimDark/My_Private_Notes.git'
2. Accédez au dossier : `cd My_Private_Notes`
3. Installez les dépendances : `flutter pub get`    
4. Lancez l'application : `flutter run`
5. Pour les tests, utilisez : `flutter test`


## 🧠 Notes techniques
- Tous les dialogues sont implémentés via une classe GenericDialog centralisée.

- Le système de Loading Screen est découplé avec OverlayEntry pour une meilleure réutilisabilité.

- Les exceptions d’authentification sont gérées et traduites de manière conviviale.

- La gestion de l’état est assurée par le Bloc pattern pour une logique claire et maintenable.

- L'app est prête pour le déploiement multi-plateforme (Android/iOS).

## ✅ Statut du projet
✔️ Finalisé 
✔️ Multilingue opérationnel
✔️ UI et UX validées

## 📛 Nom
- Nuvio = "Note" + "Privacy"
-- Un nom court, intuitif et ancré dans la mission de l’application.

## 📄 Licence
- Ce projet est libre d’utilisation à des fins personnelles, éducatives ou de démonstration