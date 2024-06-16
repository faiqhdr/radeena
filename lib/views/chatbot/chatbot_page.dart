import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/controllers/chatbot_controller.dart';

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

  void _handleInitialSelection(String selected) async {
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
        if (response.isEmpty) {
          _addMessage(
            "Sorry, I couldn't find any information on that. Please try another query.",
            "Chatbot",
          );
        } else {
          predefinedOptions = response;
          _addMessage(
            selected.toLowerCase().contains('theory')
                ? "Which theory do you want to know more about?"
                : "Which dalil do you want to know more about?",
            "Chatbot",
          );
        }
      });
    });
  }

  void _provideDetailedExplanation(String selected) async {
    _addMessage(selected, "User");
    setState(() {
      isTyping = true;
      predefinedOptions = [];
    });

    if (selectedValue.toLowerCase().contains('dalil')) {
      final dalilList = await chatbotController.getDalilList(selected);
      _showDalilList(dalilList);
    } else {
      final detailedInfo = await chatbotController.getDetailedInfo(selected);
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isTyping = false;
          if (detailedInfo != null) {
            String detailedMessage;
            if (detailedInfo.containsKey('title')) {
              detailedMessage =
                  "Sure! Here is the detailed explanation of \"${detailedInfo['title']}\".\n\nContent: ${detailedInfo['content']}\n\nSubContent: ${detailedInfo['subContent']}\n\nHope it helps 😊";
            } else if (detailedInfo.containsKey('heir')) {
              detailedMessage =
                  "Sure! Here is the detailed explanation of dalil for \"${detailedInfo['heir']}\".\n\nPortion: ${detailedInfo['portion']}\n\nCondition: ${detailedInfo['condition']}\n\nSource: ${detailedInfo['source']}\n\nEvidenceContent: ${detailedInfo['evidenceContent']}\n\nFullEvidence: ${detailedInfo['fullEvidence']}";
            } else {
              detailedMessage =
                  "Sorry, I couldn't find any information on that.";
            }
            _addMessage(detailedMessage, "Chatbot");
          } else {
            _addMessage(
              "Sorry, I couldn't find any information on that.",
              "Chatbot",
            );
          }
          _restartChat();
        });
      });
    }
  }

  void _showDalilList(List<Map<String, dynamic>> dalilList) {
    setState(() {
      isTyping = false;
      for (var dalil in dalilList) {
        String detailedMessage =
            "Source: ${dalil['source']}\n\nPortion: ${dalil['portion']}\n\nCondition: ${dalil['condition']}\n\nEvidenceContent: ${dalil['evidenceContent']}\n\nFullEvidence: ${dalil['fullEvidence']}\n\n";
        _addMessage(detailedMessage, "Chatbot");
      }
      _restartChat();
    });
  }

  void _restartChat() {
    Future.delayed(Duration(seconds: 2), () {
      _addMessage("Anything else I can help you with? 🤓", "Chatbot");
      setState(() {
        predefinedOptions = chatbotController.model.getInitialOptions();
      });
    });
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
            borderRadius: BorderRadius.circular(12),
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
              if (selectedValue.toLowerCase().contains('theory') ||
                  selectedValue.toLowerCase().contains('dalil')) {
                _provideDetailedExplanation(option['question']!);
              } else {
                _handleInitialSelection(option['question']!);
              }
            }))
        .toList();
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
