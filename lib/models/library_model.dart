class LibraryModel {
  List<Map<String, dynamic>> dalilList = [];
  List<Map<String, dynamic>> lessonList = [];

  void setDalilList(List<Map<String, dynamic>> dalilData) {
    dalilList = dalilData;
  }

  void setLessonList(List<Map<String, dynamic>> lessonData) {
    lessonList = lessonData;
  }

  List<String> getUniqueHeirs() {
    final heirs = dalilList.map((dalil) => dalil['heir'] as String).toSet().toList();
    return heirs;
  }

  List<Map<String, dynamic>> getDalilForHeir(String heir) {
    return dalilList.where((dalil) => dalil['heir'] == heir).toList();
  }

  List<Map<String, dynamic>> getLessonsByTitle(String title) {
    return lessonList.where((lesson) => lesson['title'] == title).toList();
  }

  Map<String, dynamic> getDalilByHeir(String heir) {
    return dalilList.firstWhere((dalil) => dalil['heir'] == heir, orElse: () => {});
  }
}
