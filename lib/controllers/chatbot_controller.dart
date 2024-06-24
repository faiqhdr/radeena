// ignore_for_file: unnecessary_null_comparison
import 'dart:convert'; // Import for json
import 'package:flutter/services.dart';
import 'package:radeena/models/chatbot_model.dart';
import 'package:radeena/models/library_model.dart';

class ChatbotController {
  final ChatbotModel model = ChatbotModel();
  final LibraryModel libraryModel = LibraryModel();

  Future<void> loadDalilData() async {
    final String response =
        await rootBundle.loadString('lib/models/dalil.json');
    final data = json.decode(response) as Map<String, dynamic>;
    libraryModel
        .setDalilList(List<Map<String, dynamic>>.from(data['evidence']));
  }

  Future<void> loadLessonData() async {
    final String response =
        await rootBundle.loadString('lib/models/lesson.json');
    final data = json.decode(response) as Map<String, dynamic>;
    libraryModel.setLessonList(List<Map<String, dynamic>>.from(data['lesson']));
  }

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

  Future<Map<String, dynamic>?> getDetailedInfo(String input) async {
    await loadLessonData();
    await loadDalilData();

    var lessons = libraryModel.getLessonsByTitle(input);
    if (lessons.isNotEmpty) return {"lessons": lessons};

    var dalil = libraryModel.getDalilByHeir(input);
    if (dalil != null && dalil.isNotEmpty) return dalil;

    return null;
  }

  Future<List<Map<String, dynamic>>> getDalilList(String heir) async {
    await loadDalilData();
    return libraryModel.getDalilForHeir(heir);
  }
}
