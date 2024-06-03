import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/views/tree_graph_page.dart';
import 'package:radeena/controllers/impediment_controller.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:radeena/widgets/common_button.dart';

class ImpedimentPage extends StatelessWidget {
  final List<String> impediments;
  final IdentificationController identificationController;
  final ImpedimentController impedimentController;

  const ImpedimentPage({
    Key? key,
    required this.impediments,
    required this.identificationController,
    required this.impedimentController,
  }) : super(key: key);

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
                          itemBuilder: (context, index) => ListTile(
                            title: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  impediments[index],
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  speed: const Duration(milliseconds: 50),
                                ),
                              ],
                              totalRepeatCount: 1,
                              pause: const Duration(milliseconds: 1000),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                            ),
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
                                        color: Colors.green,
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
