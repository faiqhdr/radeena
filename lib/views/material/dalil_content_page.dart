import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';

class DalilContentPage extends StatelessWidget {
  final Map<String, dynamic> dalil;
  const DalilContentPage({required this.dalil, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    List<String> evidenceParts = dalil['fullEvidence'].split('\n\n');
    String arabicPart = evidenceParts[0];
    String englishPart = evidenceParts.length > 1 ? evidenceParts[1] : '';

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
          "Library",
          style: titleDetermineHeirsStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .06),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  "Dalil Details",
                  style: textUnderTitleStyle(),
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Portion:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: green02Color),
              ),
              SizedBox(height: 5),
              Text(
                dalil['portion'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 25),
              Text(
                "Explanation:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: green02Color),
              ),
              SizedBox(height: 5),
              Text(
                dalil['condition'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 25),
              Text(
                "Dalil:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: green02Color),
              ),
              SizedBox(height: 5),
              Text(
                dalil['evidenceContent'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Complete Dalil:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: green02Color),
              ),
              SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: arabicPart,
                      style: TextStyle(
                          fontFamily: 'UthmaniHafs',
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: '\n\n',
                    ),
                    TextSpan(
                      text: englishPart,
                      style: TextStyle(
                          fontFamily: 'UthmaniHafs',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
