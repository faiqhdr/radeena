//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

class LibraryModel {
  List<Map<String, dynamic>> dalilList = []; // Store Dalil Data
  List<Map<String, dynamic>> lessonList = []; // Store Lesson Data

  // Set List of Dalil Data
  void setDalilList(List<Map<String, dynamic>> dalilData) {
    dalilList = dalilData;
  }

  // Set List of Lesson Data
  void setLessonList(List<Map<String, dynamic>> lessonData) {
    lessonList = lessonData;
  }

  // Get Heirs from Dalil List
  List<String> getUniqueHeirs() {
    final heirs =
        dalilList.map((dalil) => dalil['heir'] as String).toSet().toList();
    return heirs;
  }

  // Get Dalil Data for Specific Heir
  List<Map<String, dynamic>> getDalilForHeir(String heir) {
    return dalilList.where((dalil) => dalil['heir'] == heir).toList();
  }

  // Get Lesson Data by Title
  List<Map<String, dynamic>> getLessonsByTitle(String title) {
    return lessonList.where((lesson) => lesson['title'] == title).toList();
  }

  // Get Dalil Data for Specific Heir
  Map<String, dynamic> getDalilByHeir(String heir) {
    return dalilList.firstWhere((dalil) => dalil['heir'] == heir,
        orElse: () => {});
  }
}
