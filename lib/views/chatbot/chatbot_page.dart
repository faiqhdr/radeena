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
  bool isTyping = false;
  List<Map<String, String>> predefinedOptions = [];
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    _addMessage("Assalamualaikum Warahmatullah Wabarakatuh! 👋", "Chatbot");
    Future.delayed(Duration(seconds: 2), () {
      _addMessage("How can I help you? 🤓", "Chatbot");
      setState(() {
        predefinedOptions = chatbotController.model.getInitialOptions();
      });
    });
  }

  void _addMessage(String message, String sender) {
    setState(() {
      messages.add({"message": message, "sender": sender});
    });
  }

  void _handleDetailedSelection(String selected) async {
    _addMessage(selected, "User");
    setState(() {
      isTyping = true;
      predefinedOptions = [];
      selectedValue = selected;
    });

    List<Map<String, String>> response =
        await chatbotController.getResponse(selected);
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isTyping = false;
        predefinedOptions = response;
        if (response.isEmpty) {
          _addMessage(
            "Sorry, I couldn't find any information on that. Please try another query.",
            "Chatbot",
          );
        } else {
          _addMessage(
            selected.toLowerCase().contains('theory')
                ? "Which theory do you want to know?"
                : "Which dalil do you want to know?",
            "Chatbot",
          );
        }
      });
    });
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
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
    return predefinedOptions
        .map((option) => _buildPredefinedUserOption(option['question']!, () {
              _handleDetailedSelection(option['question']!);
            }))
        .toList();
  }

  Widget _buildSeeContentButton(String selected) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal.shade700,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        onPressed: () => _navigateToPage(selected),
        child: Text(
          "See the content",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
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
                  return Column(
                    children: [
                      _buildChatBubble(message['message']!, message['sender']!),
                      if (message['message'] == "See the content")
                        _buildSeeContentButton(selectedValue)
                    ],
                  );
                },
              ),
            ),
            if (isTyping)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 10),
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _buildPredefinedUserOptions(),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
