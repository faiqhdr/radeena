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
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                "Faraid Material",
                style: textUnderTitleStyle(),
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: Lottie.asset(
                'assets/lottie/reading.json',
                width: 400,
                height: 450,
              ),
            ),
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
