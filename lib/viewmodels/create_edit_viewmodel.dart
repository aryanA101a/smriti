import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smriti/di/locator.dart';
import 'package:smriti/models/smriti_model.dart';
import 'package:smriti/repository/smriti_repository.dart';
import 'package:smriti/viewmodels/home_viewmodel.dart';

class CreateEditViewModel extends ChangeNotifier {
  final SmritiRepository _smritiRepository;
  CreateEditViewModel(this._smritiRepository);

  TextEditingController tagController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  DateTime _date = DateTime.now();
  String get date => DateFormat('dd / MM / yy').format(_date);

  @override
  void dispose() {
    super.dispose();
    tagController.dispose();
    titleController.dispose();
    bodyController.dispose();
  }

  String extractTag() {
    String tag = tagController.text;
    if (tag.isEmpty) {
      tag = "#any";
    } else if (!tag.startsWith('#')) {
      tag = '#${tagController.text}';
    }
    return tag;
  }

  bool saveSmriti() {
    log("saveSmriti #createEditViewModel");
    if (titleController.text.isEmpty && bodyController.text.isEmpty) {
      return false;
    }
    Smriti smriti = Smriti(
      tag: extractTag(),
      date: _date,
      lastUpdated: _date,
      title: titleController.text,
      body: bodyController.text,
    );
    _smritiRepository.save(smriti);
    locator<HomeViewModel>().addSmriti(smriti);
    return true;
  }

  void deleteSmriti(int id) {
    _smritiRepository.delete(id);
    locator<HomeViewModel>().deleteSmriti(id);
  }

  bool updateSmriti(Smriti smriti) {
    if (titleController.text.isEmpty && bodyController.text.isEmpty) {
      return false;
    }
    Smriti updatedSmriti = Smriti(
      id: smriti.id,
      tag: extractTag(),
      date: smriti.date,
      lastUpdated: DateTime.now(),
      title: titleController.text,
      body: bodyController.text,
    );
    _smritiRepository.save(updatedSmriti);
    locator<HomeViewModel>().updateSmriti(updatedSmriti);
    return true;
  }

  void loadSmriti(Smriti smriti) {
    _date = smriti.date;
    tagController.text = smriti.tag;
    titleController.text = smriti.title;
    bodyController.text = smriti.body;
  }
}
