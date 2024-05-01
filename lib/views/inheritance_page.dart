import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';

class InheritancePage extends StatelessWidget {
  const InheritancePage({
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
                    "Calculation Step by Step",
                    style: textUnderTitleStyle(),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "1. Total Property: 780,500,000 IDR\n"
                  "2. Deductions:\n"
                  "   - Debt: 8,500,000 IDR\n"
                  "   - Testament: 8,500,000 IDR\n"
                  "   - Funeral Expenses: 400,000 IDR\n"
                  "3. Net Inheritance: 763,100,000 IDR\n\n"
                  "Heirs and Portions:\n"
                  "   - Father: 1/6 of the Net Property = 127,183,333 IDR\n"
                  "   - Wife: 1/8 of the Net Property = 95,387,500 IDR\n"
                  "   - Sons: Residuary, 4/5 of Residue = 432,423,333 IDR\n"
                  "   - Daughters: Residuary, 1/5 of Residue = 108,105,833 IDR\n\n"
                  "Division Status:\n"
                  "   - Initial share is based on LCM of portions (6 and 8)\n"
                  "   - Residuary calculated after fixed portions\n"
                  "   - No Aul or Radd adjustments required\n\n"
                  "Final Distribution:\n"
                  "   - Each son receives: 108,105,833 IDR\n"
                  "   - Each daughter receives: 54,052,916 IDR\n",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
