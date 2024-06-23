import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/controllers/chatbot_controller.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage>
    with TickerProviderStateMixin {
  final ChatbotController chatbotController = ChatbotController();
  List<Map<String, String>> messages = [];
  bool isTyping = false;
  List<Map<String, String>> predefinedOptions = [];
  String selectedValue = '';

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initialGreeting();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 850),
      vsync: this,
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 0.3, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initialGreeting() {
    Future.delayed(Duration(seconds: 1), () {
      _addMessage("Assalamu'alaikum warahmatullah wabarakatuh! 👋", "Chatbot");
    });
    Future.delayed(Duration(seconds: 2), () {
      _addMessage("How can I help you? 😇🙏", "Chatbot");
    }).then((_) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          predefinedOptions = chatbotController.model.getInitialOptions();
        });
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
            selected.toLowerCase().contains('lesson')
                ? "Which topic do you want to know more about? 🧐"
                : "Which dalil do you want to know more about? 🧐",
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

    if (selectedValue.toLowerCase().contains('lesson')) {
      final detailedInfo = await chatbotController.getDetailedInfo(selected);

      if (detailedInfo != null && detailedInfo.containsKey('lessons')) {
        setState(() {
          isTyping = true;
        });
        await Future.delayed(Duration(seconds: 2));
        setState(() {
          isTyping = false;
          String introMessage =
              "Sure! Here is the detailed explanation of \"${selected}\". 😉👌";
          _addMessage(introMessage, "Chatbot");
        });
        for (var lesson in detailedInfo['lessons']) {
          setState(() {
            isTyping = true;
          });
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            isTyping = false;
            String detailedMessage =
                "${lesson['content']}\n\n${lesson['subContent']}";
            _addMessage(detailedMessage, "Chatbot");
          });
        }
        setState(() {
          isTyping = true;
        });
        await Future.delayed(Duration(seconds: 2));
        setState(() {
          isTyping = false;
          _addMessage("I hope that clarifies your question! 😊", "Chatbot");
          _restartChat();
        });
      } else {
        await Future.delayed(Duration(seconds: 2));
        setState(() {
          isTyping = false;
          _addMessage(
            "Sorry, I couldn't display the explanation on that. 😵",
            "Chatbot",
          );
          _restartChat();
        });
      }
    } else {
      final dalilList = await chatbotController.getDalilList(selected);
      _showDalilList(dalilList);
    }
  }

  void _showDalilList(List<Map<String, dynamic>> dalilList) async {
    if (dalilList.isNotEmpty) {
      setState(() {
        isTyping = true;
      });
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        isTyping = false;
        String introMessage =
            "Sure! Here is the detailed dalil of \"${dalilList[0]['heir']}\". 😉👌";
        _addMessage(introMessage, "Chatbot");
      });
    }
    for (var dalil in dalilList) {
      setState(() {
        isTyping = true;
      });
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        isTyping = false;
        String detailedMessage =
            "The source of the dalil is ${dalil['source']}, which states that the heir's portion is ${dalil['portion']}.\n\n${dalil['condition']}\n\nThis dalil says, \"${dalil['evidenceContent']}\"\n\nHere is the complete dalil for the heir along with the translation. 👇 \n\n${dalil['fullEvidence']}";
        _addMessage(detailedMessage, "Chatbot");
      });
    }
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isTyping = false;
      String detailedMessage = "Hopefully that answers your question! 😊";
      _addMessage(detailedMessage, "Chatbot");
    });
    _restartChat();
  }

  void _restartChat() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isTyping = false;
        predefinedOptions = [];
        selectedValue = '';
      });
      _addMessage("Anything else you want to ask? 🤓", "Chatbot");
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          predefinedOptions = chatbotController.model.getInitialOptions();
        });
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
          gradient: LinearGradient(
            colors: isBot
                ? [Colors.teal.shade100, Colors.blue.shade100]
                : [Colors.deepPurple.shade100, Colors.indigo.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
            color: isBot ? Colors.cyan.shade900 : Colors.purple.shade800,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPredefinedUserOption(String text, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, Colors.teal.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value,
              child: Container(
                width: 15,
                height: 15,
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal,
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value,
              child: Container(
                width: 15,
                height: 15,
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal,
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value,
              child: Container(
                width: 15,
                height: 15,
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  List<Widget> _buildPredefinedUserOptions() {
    return predefinedOptions
        .map((option) => _buildPredefinedUserOption(option['question']!, () {
              if (selectedValue.toLowerCase().contains('lesson') ||
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
        title: Row(
          children: [
            Text(
              "Chatbot",
              style: titleDetermineHeirsStyle(),
            ),
            Spacer(),
            Lottie.asset(
              'assets/lottie/chatbot.json',
              width: 90,
              height: 90,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
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
                          _buildChatBubble(
                              message['message']!, message['sender']!),
                        ],
                      );
                    },
                  ),
                ),
                if (isTyping)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                    child: _buildTypingIndicator(),
                  ),
                if (predefinedOptions.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 10),
                        child: Text(
                          "----------------- << Select Response >> -----------------",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        height: 55,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: _buildPredefinedUserOptions(),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
