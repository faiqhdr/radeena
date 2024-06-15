import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/controllers/chatbot_controller.dart';
import 'package:radeena/views/material/dalil_list_page.dart';
import 'package:radeena/views/material/theory_content_page.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final ChatbotController chatbotController = ChatbotController();
  List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    _addMessage("How can I help you?", "Chatbot");
  }

  void _addMessage(String message, String sender) {
    setState(() {
      messages.add({"message": message, "sender": sender});
    });
  }

  void _handleSelection(String selected) async {
    _addMessage(selected, "User");
    List<Map<String, String>> response =
        await chatbotController.getResponse(selected);
    for (var item in response) {
      _addMessage(item['question']!, "Chatbot");
    }
    if (selected.toLowerCase().contains('theory') ||
        selected.toLowerCase().contains('dalil')) {
      _addMessage(
          chatbotController.getExplanationMessage(
              selected.toLowerCase().contains('theory') ? 'theory' : 'dalil',
              selected),
          "Chatbot");
      _addMessage("See the content", "Chatbot");
    }
  }

  void _navigateToPage(String selected) async {
    final detailedInfo = await chatbotController.getDetailedInfo(selected);
    if (detailedInfo != null) {
      if (detailedInfo.containsKey('title')) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TheoryContentPage(theory: detailedInfo),
          ),
        );
      } else if (detailedInfo.containsKey('heir')) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DalilListPage(heir: detailedInfo['heir']),
          ),
        );
      }
    }
  }

  Widget _buildChatBubble(String message, String sender) {
    bool isBot = sender == "Chatbot";
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isBot ? Colors.teal.shade100 : Colors.green.shade100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isBot ? 0 : 15),
            topRight: Radius.circular(isBot ? 15 : 0),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isBot ? Colors.black : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPredefinedUserOption(String text, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.green.shade100,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  List<Widget> _buildPredefinedUserOptions() {
    return [
      _buildPredefinedUserOption(
          "I would like to know more about Faraid’s Theory",
          () => _handleSelection("Theory")),
      _buildPredefinedUserOption(
          "I would like to know more about Faraid’s Dalil",
          () => _handleSelection("Dalil")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: green01Color,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Chatbot",
          style: titleDetermineHeirsStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                "Ask Radeena",
                style: textUnderTitleStyle(),
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return _buildChatBubble(
                      message['message']!, message['sender']!);
                },
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ..._buildPredefinedUserOptions(),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
