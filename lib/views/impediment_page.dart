import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/views/tree_graph_page.dart';
import 'package:radeena/controllers/impediment_controller.dart';

class ImpedimentPage extends StatelessWidget {
  final List<String> impediments;
  final ImpedimentController controller;

  const ImpedimentPage({
    Key? key,
    required this.impediments,
    required this.controller,
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
          onPressed: () {
            Navigator.of(context).pop();
          },
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
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Impeded Heirs",
                    style: textUnderTitleStyle(),
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: impediments.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          impediments[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 370,
              left: width * 0.06,
              right: width * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TreeGraphPage(controller: controller),
                  ));
                },
                child: Text("See Family Tree"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
