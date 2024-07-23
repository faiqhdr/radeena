//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/views/information/dalil_content_page.dart';
import 'package:radeena/controllers/library_controller.dart';

class DalilListPage extends StatefulWidget {
  final String heir;
  const DalilListPage({required this.heir, Key? key}) : super(key: key);

  @override
  _DalilListPageState createState() => _DalilListPageState();
}

class _DalilListPageState extends State<DalilListPage> {
  late Future<List<Map<String, dynamic>>> dalilListFuture;
  final libraryController = LibraryController();

  @override
  void initState() {
    super.initState();
    dalilListFuture = _loadData();
  }

  // Load Data Asynchronously
  Future<List<Map<String, dynamic>>> _loadData() async {
    await libraryController.loadDalilData();
    return libraryController.getDalilForHeir(widget.heir);
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
                "Dalil for ${widget.heir}",
                style: textUnderTitleStyle(),
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: dalilListFuture,
                builder: (context, snapshot) {
                  // Loading State
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading data'));
                  } else {
                    final dalilList = snapshot.data!;
                    return ListView.builder(
                      itemCount: dalilList.length,
                      itemBuilder: (context, index) {
                        final dalil = dalilList[index];
                        // Navigate to Dalil Content
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DalilContentPage(dalil: dalil),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor.withOpacity(0.7),
                                  secondaryColor.withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dalil['source'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.yellow.shade100,
                                      fontSize: 13,
                                    ),
                                    children: [
                                      TextSpan(text: 'Portion: '),
                                      TextSpan(
                                        text: dalil['portion'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
