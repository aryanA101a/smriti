import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:smriti/repository/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel(this._authRepository);

  Future<UserCredential?> googleSignIn() async {
    return await _authRepository.signInWithGoogle();
  }
}
