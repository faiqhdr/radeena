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
    return dataList.map((data) => {"question": data[key] as String}).toList();
  }

  String getDetailedExplanationMessage(String type, String value) {
    return 'Sure! Click the button below for a more detailed explanation of **$value**. Hope it helps 😊';
  }
}
