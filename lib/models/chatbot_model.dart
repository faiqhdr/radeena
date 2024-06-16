class ChatbotModel {
  List<Map<String, String>> predefinedQuestions = [
    {"question": "How can I help you? 🤓", "response": "How can I help you?"},
  ];

  List<Map<String, String>> getInitialOptions() {
    return [
      {"question": "I would like to know more about Faraid’s Theory"},
      {"question": "I would like to know more about Faraid’s Dalil"}
    ];
  }

  List<Map<String, String>> getQuestionsForInput(
      List<Map<String, dynamic>> dataList, String key) {
    var uniqueQuestions =
        dataList.map((data) => data[key] as String).toSet().toList();
    return uniqueQuestions.map((question) => {"question": question}).toList();
  }

  String getDetailedExplanationMessage(String type, String value) {
    return 'Sure! Here is the detailed explanation of "$value".';
  }
}
