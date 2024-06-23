import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/views/information/topic_content_page.dart';
import 'package:radeena/controllers/library_controller.dart';

class TopicListPage extends StatefulWidget {
  const TopicListPage({Key? key}) : super(key: key);

  @override
  _TopicListPageState createState() => _TopicListPageState();
}

class _TopicListPageState extends State<TopicListPage> {
  late Future<List> lessonsFuture;
  final libraryController = LibraryController();

  @override
  void initState() {
    super.initState();
    lessonsFuture = _loadData();
  }

  Future<List> _loadData() async {
    await libraryController.loadLessonData();
    return libraryController.lessonList;
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
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                "Topic",
                style: textUnderTitleStyle(),
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: FutureBuilder<List>(
                future: lessonsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading data'));
                  } else {
                    final titles = snapshot.data!
                        .map((lesson) => lesson['title'])
                        .toSet()
                        .toList();
                    return ListView.builder(
                      itemCount: titles.length,
                      itemBuilder: (context, index) {
                        final title = titles[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TopicContentPage(
                                  title: title,
                                  libraryController: libraryController,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: 58.0,
                            height: 58.0,
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
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
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
