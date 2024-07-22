//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

class ChatbotModel {
  // Predefined Questions and Responses
  List<Map<String, String>> predefinedQuestions = [
    {"question": "How can I help you? 🤓", "response": "How can I help you?"},
  ];

  // Initial Options for User
  List<Map<String, String>> getInitialOptions() {
    return [
      {"question": "I would like to know more about Faraid’s lesson"},
      {"question": "I would like to know more about Faraid’s Dalil"}
    ];
  }

  // Get Questions for Input
  List<Map<String, String>> getQuestionsForInput(
      List<Map<String, dynamic>> dataList, String key) {
    var uniqueQuestions =
        dataList.map((data) => data[key] as String).toSet().toList();
    return uniqueQuestions.map((question) => {"question": question}).toList();
  }
}
