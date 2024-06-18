import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/widgets/common_button.dart';
import 'package:radeena/views/distribution/calculation_page.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';

class ConfirmationPage extends StatelessWidget {
  final double totalProperty;
  final double propertyAmount;
  final double debtAmount;
  final double testamentAmount;
  final double funeralAmount;
  final Map<String, int> selectedHeirs;

  final IdentificationController identificationController;
  final ImpedimentController impedimentController;

  const ConfirmationPage({
    Key? key,
    required this.totalProperty,
    required this.propertyAmount,
    required this.debtAmount,
    required this.testamentAmount,
    required this.funeralAmount,
    required this.selectedHeirs,
    required this.identificationController,
    required this.impedimentController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    String formatNumber(double number) {
      return number.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}.");
    }

    List<Widget> buildHeirWidgets(Map<String, int> heirs) {
      List<Widget> heirWidgets = [];
      heirs.forEach((heir, qty) {
        heirWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withOpacity(0.7),
                        secondaryColor.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 23,
                    backgroundColor: Colors.transparent,
                    child: Text(
                      qty.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor.withOpacity(0.7),
                          secondaryColor.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      heir,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
      return heirWidgets;
    }

    Map<String, int> filteredHeirs =
        impedimentController.getFilteredHeirs(selectedHeirs);

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
          "Confirm Calculation",
          style: titleDetermineHeirsStyle(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      "Check Property & Heirs",
                      style: textUnderTitleStyle(),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "The following are the selected Heirs:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade800),
                  ),
                  SizedBox(height: 16),
                  ...buildHeirWidgets(filteredHeirs),
                  SizedBox(height: 32),
                  Text(
                    "The inheritable property ready for distribution is:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade800),
                  ),
                  SizedBox(height: 16),
                  Container(
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
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "IDR",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          formatNumber(totalProperty),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 500),
                ],
              ),
            ),
          ),
          Positioned(
            top: 640,
            left: width * 0.25,
            right: width * 0.25,
            child: CommonButton(
              text: "Calculate",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalculationPage(
                      identificationController: identificationController,
                      impedimentController: impedimentController,
                      totalProperty:
                          identificationController.property.getTotal(),
                      propertyAmount:
                          identificationController.property.getAmount(),
                      debtAmount: identificationController.property.getDebt(),
                      testamentAmount:
                          identificationController.property.getTestament(),
                      funeralAmount:
                          identificationController.property.getFuneral(),
                      selectedHeirs: filteredHeirs,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
