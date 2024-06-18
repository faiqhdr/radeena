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

    Map<String, int> filteredHeirs =
        impedimentController.getFilteredHeirs(selectedHeirs);

    List<DataRow> heirRows = filteredHeirs.entries
        .where((entry) => entry.value > 0)
        .map((entry) => DataRow(
              cells: [
                DataCell(Text(entry.key)),
                DataCell(Text(entry.value.toString())),
              ],
            ))
        .toList();

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
                  Container(
                    width: double.infinity,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Center(
                            child: Text(
                              'Heir',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Center(
                            child: Text(
                              'Quantity',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                      rows: heirRows,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Total inheritance to be distributed: Rp${formatNumber(totalProperty)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 400),
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
