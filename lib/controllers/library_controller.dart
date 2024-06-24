import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:radeena/models/library_model.dart';

class LibraryController {
  final LibraryModel model = LibraryModel();

  Future<void> loadDalilData() async {
    final String response =
        await rootBundle.loadString('lib/models/dalil.json');
    final data = json.decode(response) as Map<String, dynamic>;
    model.setDalilList(List<Map<String, dynamic>>.from(data['evidence']));
  }

  Future<void> loadLessonData() async {
    final String response =
        await rootBundle.loadString('lib/models/lesson.json');
    final data = json.decode(response) as Map<String, dynamic>;
    model.setLessonList(List<Map<String, dynamic>>.from(data['lesson']));
  }

  List<String> getUniqueHeirs() {
    return model.getUniqueHeirs();
  }

  List<Map<String, dynamic>> getDalilForHeir(String heir) {
    return model.getDalilForHeir(heir);
  }

  List<Map<String, dynamic>> getLessonsByTitle(String title) {
    return model.getLessonsByTitle(title);
  }

  Map<String, dynamic> getDalilByHeir(String heir) {
    return model.getDalilByHeir(heir);
  }
}
