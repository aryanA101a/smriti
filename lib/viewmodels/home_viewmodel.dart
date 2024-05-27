import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:smriti/models/smriti_model.dart';
import 'package:smriti/repository/auth_repository.dart';
import 'package:smriti/repository/smriti_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final SmritiRepository _smritiRepository;
  final AuthRepository _authRepository;

  HomeViewModel(this._smritiRepository, this._authRepository) {
    retrieveSmritis();
    retrieveName();
  }

  String _name = "";
  String get name => _name;

  List<Smriti> _smritis = [];
  List<Smriti> get smritis => _smritis;

  StreamController<List<Smriti>> smritisController = StreamController();

  List<String> _tags = [];
  List<String> get tags => _tags;

  void retrieveName() {
    var authStatus = _authRepository.getAuthStatus();

    if (authStatus != null) {
      _name = authStatus.name;
    }
    notifyListeners();
  }

  void retrieveSmritis() {
    log("retrieveSmritis");
    _smritiRepository.getAll(smritisController);
    smritisController.stream.listen((event) {
      _smritis = event;
      notifyListeners();
      retrieveTags();
    });
  }

  void retrieveTags() {
    _tags = _smritis
        .map(
          (e) => e.tag,
        )
        .toSet()
        .toList();
    notifyListeners();
  }

  void addSmriti(Smriti smriti) {
    _smritis = [smriti, ..._smritis];
    notifyListeners();
    retrieveTags();
  }

  int deleteSmriti(int id) {
    int index = _smritis.indexWhere((element) => element.id == id);
    if (index != -1) {
      _smritis = [
        ..._smritis.sublist(0, index),
        ..._smritis.sublist(index + 1)
      ];
      notifyListeners();
      retrieveTags();
    }
    return index;
  }

  void updateSmriti(Smriti smriti) {
    int index = _smritis.indexWhere(
      (element) => element.id == smriti.id,
    );
    if (index != -1) {
      _smritis = [
        ..._smritis.sublist(0, index),
        smriti,
        ..._smritis.sublist(index + 1)
      ];
      notifyListeners();
      retrieveTags();
    }
  }

  void restoreSmriti(int index, Smriti smriti) {
    if (index != -1) {
      _smritis = [
        ..._smritis.sublist(0, index),
        smriti,
        ..._smritis.sublist(index + 1)
      ];
      notifyListeners();
      retrieveTags();
    }
  }

  String? getProfilePhoto() {
    return _authRepository.getProfilePhoto();
  }
}
