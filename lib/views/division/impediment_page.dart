import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/widgets/common_button.dart';
import 'package:radeena/views/division/tree_graph_page.dart';
import 'package:radeena/controllers/impediment_controller.dart';
import 'package:radeena/controllers/identification_controller.dart';

class ImpedimentPage extends StatelessWidget {
  final IdentificationController identificationController;
  final ImpedimentController impedimentController;
  final FlutterTts flutterTts = FlutterTts();

  ImpedimentPage({
    Key? key,
    required this.identificationController,
    required this.impedimentController,
  }) : super(key: key);

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    List<String> impediments = impedimentController.getImpediments();

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
          "Determine Heirs",
          style: titleDetermineHeirsStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .06),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "Impeded Heirs",
                    style: textUnderTitleStyle(),
                  ),
                ),
                SizedBox(height: 25),
                Expanded(
                  child: impediments.isNotEmpty
                      ? ListView.builder(
                          itemCount: impediments.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          primaryColor.withOpacity(0.7),
                                          secondaryColor.withOpacity(0.7),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextButton(
                                      onPressed: () =>
                                          _speak(impediments[index]),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.volume_up,
                                              color: Colors.white, size: 16),
                                          SizedBox(width: 5),
                                          Text(
                                            'Hear Sound',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ListTile(
                                      title: AnimatedTextKit(
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                            impediments[index],
                                            textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.teal.shade800,
                                            ),
                                            speed: const Duration(
                                                milliseconds: 50),
                                          ),
                                        ],
                                        totalRepeatCount: 1,
                                        pause:
                                            const Duration(milliseconds: 500),
                                        displayFullTextOnTap: true,
                                        stopPauseOnTap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        )
                      : Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 5,
                                child: Lottie.asset(
                                  'assets/lottie/no_impediment.json',
                                  width: 340,
                                  height: 450,
                                ),
                              ),
                              Positioned(
                                bottom: 240,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      'No heirs impeded. \nAll will get the inheritance ✨',
                                      textStyle: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal.shade800,
                                      ),
                                      speed: const Duration(milliseconds: 50),
                                    ),
                                  ],
                                  totalRepeatCount: 4,
                                  pause: const Duration(milliseconds: 1000),
                                  displayFullTextOnTap: true,
                                  stopPauseOnTap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
            Positioned(
              bottom: 60,
              left: width * 0.22,
              right: width * 0.22,
              child: CommonButton(
                text: "See Family Tree",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TreeGraphPage(
                      identificationController: identificationController,
                      impedimentController: impedimentController,
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
