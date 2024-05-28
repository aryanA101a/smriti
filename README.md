# Smriti
An elegant notes app.
<p float="left">
<img src="https://github.com/aryanA101a/smriti/assets/23309033/30e22834-d93f-4766-b762-3cbcc74ae355" width="20%">
<img src="https://github.com/aryanA101a/smriti/assets/23309033/61d795ab-be28-44f9-ae2b-67e0e45dbd69" width="20%">
<img src="https://github.com/aryanA101a/smriti/assets/23309033/b0369d80-4a78-49d3-bb9b-45d15c7e554a" width="20%">

</p>


## Milestones 🚩
- [x] Local Cache
- [x] Cloud Sync with firebase_firestore      
- [ ] Full offline mode
- [ ] Better error handling

## Project Structure 🧬
```
lib
├── di
│   └── locator.dart
├── firebase_options.dart
├── main.dart
├── models
│   ├── auth_status_model.dart
│   └── smriti_model.dart
├── objectbox.g.dart
├── objectbox-model.json
├── repository
│   ├── auth_repository.dart
│   └── smriti_repository.dart
├── services
│   ├── auth_service.dart
│   ├── cache_service.dart
│   └── firestore_service.dart
├── utils
│   └── theme.dart
├── viewmodels
│   ├── create_edit_viewmodel.dart
│   ├── home_viewmodel.dart
│   └── login_viewmodel.dart
└── views
    ├── create_edit_page.dart
    ├── home_page.dart
    └── login_page.dart
```

## Run 🏃
1. Setup firebase, specifically enable google auth and cloud firestore.
2. `dart format .`
3. `flutter analyze --fatal-warnings`
4. `flutter run`

## Dependencies 🖇️
1. get_it (Dependency Injection)
2. provider (State Management)
3. objectbox (Local Database)
4. cloud_firestore (Cloud Database)

## Contributing 🎉
Pull requests are welcome.  
- Please make sure to follow the development style.  
- For major changes, please open an issue first, and discuss, what you would like to change.

