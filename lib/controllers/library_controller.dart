//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:radeena/models/library_model.dart';

class LibraryController {
  final LibraryModel model = LibraryModel();

  // Asynchronously Load Dalil Data from JSON and Update Model
  Future<void> loadDalilData() async {
    final String response =
        await rootBundle.loadString('lib/models/dalil.json');
    final data = json.decode(response) as Map<String, dynamic>;
    model.setDalilList(List<Map<String, dynamic>>.from(data['evidence']));
  }

  // Asynchronously Load Lesson Data from JSON and Update Model
  Future<void> loadLessonData() async {
    final String response =
        await rootBundle.loadString('lib/models/lesson.json');
    final data = json.decode(response) as Map<String, dynamic>;
    model.setLessonList(List<Map<String, dynamic>>.from(data['lesson']));
  }

  // Retrieve List of Heirs
  List<String> getUniqueHeirs() {
    return model.getUniqueHeirs();
  }

  // Retrieve Dalil Data for Specific Heir
  List<Map<String, dynamic>> getDalilForHeir(String heir) {
    return model.getDalilForHeir(heir);
  }

  // Retrieve Lessons by Title
  List<Map<String, dynamic>> getLessonsByTitle(String title) {
    return model.getLessonsByTitle(title);
  }

  // Retrieve Dalil Data for Specific Heir from Model
  Map<String, dynamic> getDalilByHeir(String heir) {
    return model.getDalilByHeir(heir);
  }
}
