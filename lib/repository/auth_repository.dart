import 'package:firebase_auth/firebase_auth.dart';
import 'package:smriti/models/auth_status_model.dart';
import 'package:smriti/services/auth_service.dart';
import 'package:smriti/services/cache_service.dart';

class AuthRepository {
  final AuthService _authService;
  final CacheService _cacheService;

  AuthRepository(this._authService, this._cacheService);

  Future<UserCredential?> signInWithGoogle() async {
    UserCredential? userCredential = await _authService.signInWithGoogle();
    if (userCredential != null && userCredential.user != null) {
      _cacheService.setAuthStatus(
        userCredential.user!.displayName!,
        userCredential.user!.email!,
      );
    }
    return userCredential;
  }

  Future<void> signOut() async {
    _authService.signOut();
    _cacheService.removeAuthStatus();
  }

  AuthStatus? getAuthStatus() {
    return _cacheService.getAuthStatus();
  }
}
