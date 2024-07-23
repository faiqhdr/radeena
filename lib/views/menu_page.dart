//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';

class MenuPage extends StatelessWidget {
  final IdentificationController identificationController;
  final ImpedimentController impedimentController;

  MenuPage({
    Key? key,
    required this.identificationController,
    required this.impedimentController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.1,
        centerTitle: true,
        title: Text(
          "رَضِيْنَا ☾",
          style: TextStyle(
            fontFamily: 'UthmaniHafs',
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: teal01nColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: height * .03,
                  bottom: height * .06,
                ),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/tagline.png"),
                      width: width * 0.78,
                    ),
                  ],
                ),
              ),
              // Determine Heirs Service
              DeterminationWidget(
                height: height,
                width: width,
                onPressed: () {
                  print("Directed to Determination Page");
                  Navigator.pushNamed(context, '/identificationPage');
                },
              ),
              Row(
                children: [
                  Column(
                    children: [
                      // History Service
                      CustomWidget(
                        width: width,
                        height: height * .45,
                        image: 'assets/menu_page/save.png',
                        iconHeight: 80,
                        iconWidth: 80,
                        title: 'History',
                        subtitle: 'Past Calculation',
                        colorOne: grey01nColor,
                        colorTwo: grey01Color,
                        onPressed: () {
                          print("Directed to History Page");
                          Navigator.pushNamed(context, '/historyPage');
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      // Library Service
                      CustomWidget(
                        width: width,
                        height: height * .23,
                        image: 'assets/menu_page/al_quran.png',
                        iconHeight: 80,
                        iconWidth: 80,
                        title: 'Library',
                        subtitle: 'Reference Source',
                        colorOne: indigo01Color,
                        colorTwo: indigo02Color,
                        onPressed: () {
                          print("Directed to Library Page");
                          Navigator.pushNamed(context, '/libraryPage');
                        },
                      ),
                      // Chatbox Service
                      CustomWidget(
                        width: width,
                        height: height * .19,
                        image: 'assets/menu_page/chat_information.png',
                        iconHeight: 65,
                        iconWidth: 80,
                        title: 'Ask Chatbot',
                        subtitle: 'Inquiry',
                        colorOne: blue01Color,
                        colorTwo: blue02Color,
                        onPressed: () {
                          print("Directed to Chatbot Page");
                          Navigator.pushNamed(context, '/chatbotPage');
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DeterminationWidget extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onPressed;

  DeterminationWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height * .14,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(1.5, 3),
            )
          ],
          image: DecorationImage(
            image: AssetImage("assets/menu_page/dashboard.png"),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor.withOpacity(0.7),
                secondaryColor.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .03),
                child: SizedBox(
                  width: width * .46,
                  child: ListTile(
                    title: Text(
                      "Determine Heirs",
                      style: titleStyle(),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Distribute Wealth",
                          style: subtitleStyle(),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 13,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: width * .04),
                child: SizedBox(
                  height: height * .09,
                  width: width * .3,
                  child: Image.asset(
                    "assets/menu_page/calculator.png",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomWidget extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final double iconHeight;
  final double iconWidth;
  final String title;
  final String subtitle;
  final Color colorOne;
  final Color colorTwo;
  final VoidCallback onPressed;

  CustomWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.image,
    required this.iconHeight,
    required this.iconWidth,
    required this.title,
    required this.subtitle,
    required this.colorOne,
    required this.colorTwo,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(top: width * .06),
        child: Container(
          height: height,
          width: width * .4,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(1.5, 3),
              )
            ],
            image: DecorationImage(
              image: AssetImage("assets/menu_page/dashboard.png"),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorOne.withOpacity(0.7),
                  colorTwo.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * .04,
                vertical: height * .15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage(image),
                    height: iconHeight,
                    width: iconWidth,
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: width * .02),
                    child: Text(
                      title,
                      style: titleStyle(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * .02),
                    child: SubtitleWidget(
                      subtitle: subtitle,
                      onPressed: onPressed,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SubtitleWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String subtitle;

  SubtitleWidget({
    Key? key,
    required this.onPressed,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Text(subtitle, style: miniStyle()),
          SizedBox(width: 5),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 13,
          )
        ],
      ),
    );
  }
}
