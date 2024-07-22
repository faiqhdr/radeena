//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:radeena/models/chatbot_model.dart';
import 'package:radeena/models/library_model.dart';

class ChatbotController {
  final ChatbotModel model = ChatbotModel();
  final LibraryModel libraryModel = LibraryModel();

  // Load Dalil Data from JSON
  Future<void> loadDalilData() async {
    final String response =
        await rootBundle.loadString('lib/models/dalil.json');
    final data = json.decode(response) as Map<String, dynamic>;
    libraryModel
        .setDalilList(List<Map<String, dynamic>>.from(data['evidence']));
  }

  // Load Lesson Data from JSON
  Future<void> loadLessonData() async {
    final String response =
        await rootBundle.loadString('lib/models/lesson.json');
    final data = json.decode(response) as Map<String, dynamic>;
    libraryModel.setLessonList(List<Map<String, dynamic>>.from(data['lesson']));
  }

  // Get Responses Based On Input
  Future<List<Map<String, String>>> getResponse(String input) async {
    if (input.toLowerCase().contains('lesson')) {
      await loadLessonData();
      return model.getQuestionsForInput(libraryModel.lessonList, 'title');
    } else if (input.toLowerCase().contains('dalil')) {
      await loadDalilData();
      return model.getQuestionsForInput(libraryModel.dalilList, 'heir');
    } else {
      return Future.value([
        {"question": "Hmm... Something is not right. 🤔"}
      ]);
    }
  }

  // Get Detailed Information Based On Input 
  Future<Map<String, dynamic>?> getDetailedInfo(String input) async {
    await loadLessonData();
    await loadDalilData();

    var lessons = libraryModel.getLessonsByTitle(input);
    if (lessons.isNotEmpty) return {"lessons": lessons};

    // ignore_for_file: unnecessary_null_comparison
    var dalil = libraryModel.getDalilByHeir(input);
    if (dalil != null && dalil.isNotEmpty) return dalil;

    return null;
  }

  // Get List of Dalil Based On Heir
  Future<List<Map<String, dynamic>>> getDalilList(String heir) async {
    await loadDalilData();
    return libraryModel.getDalilForHeir(heir);
  }
}
