import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';

class CalculationPage extends StatelessWidget {
  const CalculationPage({
    Key? key,
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
          "Calculation",
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
                    "Inheritance Distribution",
                    style: textUnderTitleStyle(),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
            Positioned(
              bottom: 370,
              left: width * 0.06,
              right: width * 0.06,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Save Result"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
