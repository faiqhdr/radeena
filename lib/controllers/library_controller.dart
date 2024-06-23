import 'dart:convert';
import 'package:flutter/services.dart';

class LibraryController {
  List<Map<String, dynamic>> dalilList = [];
  List<Map<String, dynamic>> lessonList = [];

  LibraryController() {
    loadDalilData();
    loadLessonData();
  }

  Future<void> loadDalilData() async {
    final String response =
        await rootBundle.loadString('lib/models/dalil.json');
    final data = await json.decode(response);
    dalilList = List<Map<String, dynamic>>.from(data['evidence']);
  }

  Future<void> loadLessonData() async {
    final String response =
        await rootBundle.loadString('lib/models/lesson.json');
    final data = await json.decode(response);
    lessonList = List<Map<String, dynamic>>.from(data['lesson']);
  }

  List getUniqueHeirs() {
    final heirs = dalilList.map((dalil) => dalil['heir']).toSet().toList();
    return heirs;
  }

  List<Map<String, dynamic>> getDalilForHeir(String heir) {
    return dalilList.where((dalil) => dalil['heir'] == heir).toList();
  }

  List<Map<String, dynamic>> getLessonsByTitle(String title) {
    return lessonList.where((lesson) => lesson['title'] == title).toList();
  }

  Map<String, dynamic> getDalilByHeir(String heir) {
    return dalilList.firstWhere((dalil) => dalil['heir'] == heir,
        orElse: () => {});
  }
}
