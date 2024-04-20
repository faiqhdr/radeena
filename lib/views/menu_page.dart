import 'package:flutter/material.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';
import 'package:radeena/styles/style.dart';

class MenuPage extends StatelessWidget {
  MenuPage(
      {Key? key,
      required IdentificationController identificationController,
      required ImpedimentController impedimentController})
      : super(key: key);

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
        // leading: Icon(
        //   Icons.menu,
        //   color: greenColor,
        // ),
        title: Text(
          "Radeena",
          style: titleGreenStyle(),
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
                  bottom: height * .03,
                ),
                child: Image(
                  image: AssetImage("assets/menu_page/radeena.png"),
                  width: width * 0.3,
                ),
              ),
              DeterminationWidget(
                height: height,
                width: width,
                onPressed: () {
                  print("DeterminationWidget pressed");
                  Navigator.pushNamed(context, '/identificationPage');
                },
              ),
              Row(
                children: [
                  Column(
                    children: [
                      CustomWidget(
                        width: width,
                        height: height * .45,
                        image: 'assets/menu_page/location.png',
                        title: 'History',
                        subtitle: 'Past Calculation',
                        colorOne: cyan01Color,
                        colorTwo: cyan02Color,
                        onPressed: () {
                          print("DeterminationWidget pressed");
                          Navigator.pushNamed(context, '/identificationPage');
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      CustomWidget(
                        width: width,
                        height: height * .23,
                        image: 'assets/menu_page/bookmark.png',
                        title: 'Library',
                        subtitle: 'Reference Source',
                        colorOne: indigo01Color,
                        colorTwo: indigo02Color,
                        onPressed: () {
                          print("DeterminationWidget pressed");
                          Navigator.pushNamed(context, '/identificationPage');
                        },
                      ),
                      CustomWidget(
                        width: width,
                        height: height * .19,
                        image: 'assets/menu_page/prayer.png',
                        title: 'Ask Chatbot',
                        subtitle: 'Inquiry',
                        colorOne: blue01Color,
                        colorTwo: blue02Color,
                        onPressed: () {
                          print("DeterminationWidget pressed");
                          Navigator.pushNamed(context, '/identificationPage');
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
  DeterminationWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  final double height;
  final double width;
  final VoidCallback onPressed;

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
                  height: height * .15,
                  width: width * .3,
                  child: Image.asset("assets/menu_page/lamp.png"),
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
  CustomWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.colorOne,
    required this.colorTwo,
    required this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;
  String image, title, subtitle;
  Color colorOne, colorTwo;
  final VoidCallback onPressed;

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
                    width: width * .15,
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
                      onPressed: () {},
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
  SubtitleWidget({
    Key? key,
    required this.onPressed,
    required this.subtitle,
  }) : super(key: key);

  final VoidCallback onPressed;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Text(subtitle, style: miniStyle()),
          SizedBox(
            width: 5,
          ),
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
