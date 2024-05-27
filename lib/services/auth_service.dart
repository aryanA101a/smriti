import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  String? profilePhoto() {
    return _firebaseAuth.currentUser?.photoURL;
  }

  void signOut() {
    try {
      _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
