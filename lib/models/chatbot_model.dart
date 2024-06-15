class ChatbotModel {
  List<Map<String, String>> predefinedQuestions = [
    {"question": "How can I help you?", "response": "How can I help you?"},
  ];

  List<Map<String, String>> getInitialOptions() {
    return [
      {"question": "Theory"},
      {"question": "Dalil"}
    ];
  }

  List<Map<String, String>> getQuestionsForInput(
      String input, List<Map<String, dynamic>> dataList, String key) {
    List<Map<String, String>> questions = [];
    if (input.toLowerCase().contains('theory')) {
      questions =
          dataList.map((data) => {"question": data[key] as String}).toList();
    } else if (input.toLowerCase().contains('dalil')) {
      questions =
          dataList.map((data) => {"question": data[key] as String}).toList();
    }
    return questions;
  }

  String getDetailedExplanationMessage(String type, String titleOrHeir) {
    if (type.toLowerCase() == 'theory') {
      return 'Sure! Click the button below for a more detailed explanation of "$titleOrHeir". Hope it helps 😊';
    } else if (type.toLowerCase() == 'dalil') {
      return 'Sure! Click the button below for a more detailed explanation of "dalil for $titleOrHeir". Hope it helps 😊';
    }
    return '';
  }
}
