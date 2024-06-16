class ChatbotModel {
  List<Map<String, String>> getInitialOptions() {
    return [
      {"question": "I would like to know more about Faraid’s Theory"},
      {"question": "I would like to know more about Faraid’s Dalil"}
    ];
  }

  List<Map<String, String>> getQuestionsForInput(
      List<Map<String, dynamic>> dataList, String key) {
    return dataList.map((data) => {"question": data[key] as String}).toList();
  }
}
