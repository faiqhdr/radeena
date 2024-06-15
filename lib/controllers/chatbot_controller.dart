import 'package:radeena/models/chatbot_model.dart';
import 'package:radeena/controllers/library_controller.dart';

class ChatbotController {
  final ChatbotModel model = ChatbotModel();
  final LibraryController libraryController = LibraryController();

  Future<List<Map<String, String>>> getResponse(String input) async {
    if (input.toLowerCase().contains('theory')) {
      await libraryController.loadTheoryData();
      return model.getQuestionsForInput(libraryController.theoryList, 'title');
    } else if (input.toLowerCase().contains('dalil')) {
      await libraryController.loadDalilData();
      return model.getQuestionsForInput(libraryController.dalilList, 'heir');
    } else {
      return Future.value([
        {"question": "Halo?"}
      ]);
    }
  }

  Future<Map<String, dynamic>?> getDetailedInfo(String input) async {
    if (input.toLowerCase().contains('theory')) {
      await libraryController.loadTheoryData();
      return libraryController.getTheoryByTitle(input);
    } else if (input.toLowerCase().contains('dalil')) {
      await libraryController.loadDalilData();
      return libraryController.getDalilByHeir(input);
    }
    return null;
  }
}
