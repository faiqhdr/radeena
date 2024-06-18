import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/views/distribution/inheritance_page.dart';
import 'package:radeena/views/distribution/heir_page.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';
import 'package:radeena/controllers/calculation_controller.dart';
import 'package:radeena/controllers/history_controller.dart';

class CalculationPage extends StatelessWidget {
  final double totalProperty;
  final double propertyAmount;
  final double debtAmount;
  final double testamentAmount;
  final double funeralAmount;
  final Map<String, int> selectedHeirs;

  final IdentificationController identificationController;
  final ImpedimentController impedimentController;

  const CalculationPage({
    Key? key,
    required this.totalProperty,
    required this.propertyAmount,
    required this.selectedHeirs,
    required this.debtAmount,
    required this.testamentAmount,
    required this.funeralAmount,
    required this.identificationController,
    required this.impedimentController,
  }) : super(key: key);

  String formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
  }

  void _showResetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Reset"),
          content: Text(
              "Are you sure you want to reset the calculation and go to the home page?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Restart.restartApp();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    CalculationController controller = CalculationController();

    Map<String, int> filteredHeirs =
        impedimentController.getFilteredHeirs(selectedHeirs);

    var result = controller.calculateInheritance(totalProperty, filteredHeirs);
    Map<String, double> distribution = result['distribution'];
    String divisionStatus = result['divisionStatus'];
    int finalShare = result['finalShare'];

    List<DataRow> heirRows = filteredHeirs.entries
        .where((entry) => entry.value > 0)
        .map((entry) => DataRow(
              cells: [
                DataCell(
                  Tooltip(
                    message: "Click to see details",
                    child: GestureDetector(
                      child: Text(
                        entry.key,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeirPage(
                              heir: entry.key,
                              quantity: entry.value,
                              totalInheritance: distribution[entry.key] ?? 0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                DataCell(Center(child: Text(entry.value.toString()))),
                DataCell(
                    Text("Rp${formatNumber(distribution[entry.key] ?? 0)}")),
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
          "Calculation",
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
                      "Inheritance Distribution",
                      style: textUnderTitleStyle(),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Net Property       : Rp${formatNumber(totalProperty)}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Division Status   : $divisionStatus",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Final Share         : $finalShare",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.grey, size: 15),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Click on the heir's row to see individual inheritance details.",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Heir')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Inheritance')),
                    ],
                    rows: heirRows,
                  ),
                  if (distribution.containsKey('Kinsfolk or Baitul Maal'))
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "All the inheritance will be given to kinsfolk or Baitul Maal.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  SizedBox(height: 500),
                ],
              ),
            ),
          ),
          Positioned(
            top: 640,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGradientButton(
                  text: "Distribution Detail",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InheritancePage(
                          identificationController: identificationController,
                          impedimentController: impedimentController,
                          totalProperty:
                              identificationController.property.getTotal(),
                          propertyAmount:
                              identificationController.property.getAmount(),
                          debtAmount:
                              identificationController.property.getDebt(),
                          testamentAmount:
                              identificationController.property.getTestament(),
                          funeralAmount:
                              identificationController.property.getFuneral(),
                          selectedHeirs: impedimentController.heirQuantity,
                        ),
                      ),
                    );
                  },
                ),
                _buildGradientButton(
                  text: "Save Result",
                  onPressed: () async {
                    TextEditingController nameController =
                        TextEditingController();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Save Calculation"),
                          content: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                                hintText: "Enter calculation name"),
                          ),
                          actions: [
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("Save"),
                              onPressed: () async {
                                String calculationName = nameController.text;
                                HistoryController historyController =
                                    HistoryController();
                                await historyController.saveCalculation(
                                  calculationName,
                                  totalProperty,
                                  propertyAmount,
                                  debtAmount,
                                  testamentAmount,
                                  funeralAmount,
                                  selectedHeirs,
                                  distribution,
                                  divisionStatus,
                                  finalShare,
                                );
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Calculation successfully saved!")),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                _buildGradientButton(
                  icon: Icons.home,
                  onPressed: () {
                    _showResetConfirmationDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(
      {String? text, IconData? icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade300, Colors.teal.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(17),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: text != null
            ? Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              )
            : Icon(icon, color: Colors.white, size: 26),
      ),
    );
  }
}
