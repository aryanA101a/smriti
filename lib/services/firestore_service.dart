import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smriti/models/smriti_model.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> saveSmriti(SmritiDto smriti) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return false;
    }

    try {
      String userId = user.uid;
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('smritis')
          .doc(smriti.id.toString())
          .set(smriti.toMap());
      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> saveSmritis(List<SmritiDto> smritis) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return false;
    }
    try {
      String userId = user.uid;
      WriteBatch batch = _firestore.batch();
      for (var smriti in smritis) {
        DocumentReference docRef = _firestore
            .collection('users')
            .doc(userId)
            .collection('smritis')
            .doc(smriti.id.toString());
        batch.set(docRef, smriti.toMap());
      }
      await batch.commit();
      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<SmritiDto?> getSmriti(int id) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    String userId = user.uid;
    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('smritis')
        .doc(id.toString())
        .get();

    if (doc.exists) {
      return SmritiDto.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<SmritiDto>?> getAllSmritis() async {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    }

    String userId = user.uid;
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('smritis')
        .get();

    return querySnapshot.docs
        .map((doc) => SmritiDto.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteSmriti(int id) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    String userId = user.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('smritis')
        .doc(id.toString())
        .delete();
  }
}
