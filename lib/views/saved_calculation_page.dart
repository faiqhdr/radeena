import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';

class SavedCalculationPage extends StatelessWidget {
  final Map<String, dynamic> calculation;

  const SavedCalculationPage({Key? key, required this.calculation}) : super(key: key);

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
          "History",
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
                    calculation['calculationName'],
                    style: textUnderTitleStyle(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Net Property: ${calculation['totalProperty']}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Division Status: ${calculation['divisionStatus']}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Final Share: ${calculation['finalShare']}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 15),
                // Display additional calculation details here
              ],
            ),
          ],
        ),
      ),
    );
  }
}
