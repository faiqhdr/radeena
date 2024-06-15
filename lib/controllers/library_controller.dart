import 'dart:convert';
import 'package:flutter/services.dart';

class LibraryController {
  List<Map<String, dynamic>> dalilList = [];
  List<Map<String, dynamic>> theoryList = [];

  LibraryController() {
    loadDalilData();
    loadTheoryData();
  }

  Future<void> loadDalilData() async {
    final String response =
        await rootBundle.loadString('lib/models/dalil.json');
    final data = await json.decode(response);
    dalilList = List<Map<String, dynamic>>.from(data['evidence']);
  }

  Future<void> loadTheoryData() async {
    final String response =
        await rootBundle.loadString('lib/models/theory.json');
    final data = await json.decode(response);
    theoryList = List<Map<String, dynamic>>.from(data['theory']);
  }

  List getUniqueHeirs() {
    final heirs = dalilList.map((dalil) => dalil['heir']).toSet().toList();
    return heirs;
  }

  List<Map<String, dynamic>> getDalilForHeir(String heir) {
    return dalilList.where((dalil) => dalil['heir'] == heir).toList();
  }

  Map<String, dynamic> getTheoryByTitle(String title) {
    return theoryList.firstWhere((theory) => theory['title'] == title,
        orElse: () => {});
  }

  Map<String, dynamic> getDalilByHeir(String heir) {
    return dalilList.firstWhere((dalil) => dalil['heir'] == heir,
        orElse: () => {});
  }
}
