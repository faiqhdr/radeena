import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';
import 'package:radeena/views/calculation_page.dart';

class ConfirmationPage extends StatelessWidget {
  final double totalProperty;
  final Map<String, int> selectedHeirs;

  final IdentificationController identificationController;
  final ImpedimentController impedimentController;

  const ConfirmationPage({
    Key? key,
    required this.totalProperty,
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

    List<DataRow> heirRows = selectedHeirs.entries
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
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "Check Property & Heirs",
                      style: textUnderTitleStyle(),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: width * 0.03,
                      horizontalMargin: width * 0.05,
                      headingRowHeight: 48,
                      dataRowMinHeight: 20,
                      dataRowMaxHeight: 40,
                      showCheckboxColumn: false,
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
                    "Total inheritance to be distributed: ${formatNumber(totalProperty)} IDR",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: width * 0.37,
            right: width * 0.37,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalculationPage(
                      identificationController: identificationController,
                      impedimentController: impedimentController,
                      totalProperty:
                          identificationController.property.getTotal(),
                      selectedHeirs: impedimentController.heirQuantity,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text("Calculate"),
            ),
          ),
        ],
      ),
    );
  }
}
