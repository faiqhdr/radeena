import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';

class ImpedimentnPage extends StatelessWidget {
  ImpedimentnPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.1,
        leading: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: green01Color,
        ),
        title: Text(
          "Determine Heirs",
          style: titleDetermineHeirsStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  "Gender of the Deceased",
                  style: textUnderTitleStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: Text(
                  "Select the Gender",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
