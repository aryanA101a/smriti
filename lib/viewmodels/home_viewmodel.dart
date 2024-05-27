import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:smriti/models/smriti_model.dart';
import 'package:smriti/repository/smriti_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final SmritiRepository _smritiRepository;

  HomeViewModel(this._smritiRepository) {
    retrieveSmritis();
    retrieveTags();
  }

  List<Smriti> _smritis = [];
  List<String> _tags = [];

  List<Smriti> get smritis => _smritis;
  List<String> get tags => _tags;

  void retrieveSmritis() {
    _smritis = _smritiRepository.getAll();
    notifyListeners();
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

  void deleteSmriti(int id) {
    int index = _smritis.indexWhere((element) => element.id == id);
    if (index != -1) {
      _smritis = [
        ..._smritis.sublist(0, index),
        ..._smritis.sublist(index + 1)
      ];
      notifyListeners();
      retrieveTags();
    }
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
}
