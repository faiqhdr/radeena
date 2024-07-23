//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/views/information/dalil_heir_page.dart';
import 'package:radeena/views/information/topic_list_page.dart';
import 'package:radeena/controllers/library_controller.dart';

class LibraryPage extends StatelessWidget {
  final LibraryController libraryController = LibraryController();

  LibraryPage({Key? key}) : super(key: key);

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
          "Library",
          style: titleDetermineHeirsStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Subtitle
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                "Faraid Material",
                style: textUnderTitleStyle(),
              ),
            ),
            Center(
              child: Lottie.asset(
                'assets/lottie/library.json',
                width: 400,
                height: 300,
              ),
            ),
            // Faraid Dalil
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.shade100.withOpacity(0.1),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Umar ibn Al-Khattab radhiyallahu 'anhu said,",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.green.shade600,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.teal.shade100.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "تَعَلَّمُوا الفَرَائِضَ وَاللُّحُونَ - النَّحْوَ - وَالسُّنَنَ كَمَا تَعَلَّمُوا القُرْآنَ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'UthmaniHafs',
                  fontSize: 34,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.shade100.withOpacity(0.2),
                    Colors.white.withOpacity(0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "\"Learn Fara'id and the poetry (Al-Lahn), –Nahwu–, \nas you learn the Sunnah just as you learn the Qur'an.\" \n﴾ Narrated by Ad-Darimi in his Sunan ﴿",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            // Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLibraryButton(
                  context,
                  'Insight',
                  TopicListPage(),
                ),
                _buildLibraryButton(
                  context,
                  'Dalil',
                  DalilHeirPage(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibraryButton(BuildContext context, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.withOpacity(0.7),
              secondaryColor.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(17.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
