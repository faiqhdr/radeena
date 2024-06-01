import 'package:flutter/material.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/controllers/calculation_controller.dart';

class InheritancePage extends StatelessWidget {
  final double totalProperty;
  final double propertyAmount;
  final double debtAmount;
  final double testamentAmount;
  final double funeralAmount;
  final Map<String, int> selectedHeirs;

  final IdentificationController identificationController;
  final ImpedimentController impedimentController;

  const InheritancePage({
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

  String formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
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

    Map<String, dynamic> portions = {
      'Father': '1/6',
      'Mother': (filteredHeirs.containsKey('Son') ||
              filteredHeirs.containsKey('Daughter'))
          ? '1/6'
          : '1/3',
      'Husband': (filteredHeirs.containsKey('Son') ||
              filteredHeirs.containsKey('Daughter'))
          ? '1/4'
          : '1/2',
      'Wife': (filteredHeirs.containsKey('Son') ||
              filteredHeirs.containsKey('Daughter'))
          ? '1/8'
          : '1/4',
      'Son': 'Residue',
      'Daughter': 'Residue',
      'Grandson': '1/6',
      'Granddaughter': '1/3',
      'Paternal Grandfather': '1/6',
      'Paternal Grandmother': '1/6',
      'Maternal Grandmother': '1/6',
      'Brother': 'residue',
      'Sister': filteredHeirs['Sister'] == 1
          ? '1/2'
          : filteredHeirs['Sister'] != null && filteredHeirs['Sister']! > 1
              ? '2/3'
              : 'Residue',
      'Maternal Half Brother': 'Residue',
      'Maternal Half Sister': filteredHeirs['Maternal Half Sister'] == 1
          ? '1/2'
          : filteredHeirs['Maternal Half Sister'] != null &&
                  filteredHeirs['Maternal Half Sister']! > 1
              ? '2/3'
              : 'Residue',
      'Paternal Half Brother': 'Residue',
      'Paternal Half Sister': filteredHeirs['Paternal Half Sister'] == 1
          ? '1/2'
          : filteredHeirs['Paternal Half Sister'] != null &&
                  filteredHeirs['Paternal Half Sister']! > 1
              ? '2/3'
              : 'Residue',
      'Son of Paternal Half Brother': 'Residue',
      'Uncle': 'Residue',
      'Paternal Uncle': 'Residue',
      'Son of Paternal Uncle': 'Residue',
      'Son of Uncle': 'Residue'
    };

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  "Distribution Detail",
                  style: textUnderTitleStyle(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Property Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Property')),
                  DataColumn(label: Text('Amount')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text("Total Property")),
                    DataCell(Text("IDR ${formatNumber(propertyAmount)}")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Deceased's Debt")),
                    DataCell(Text("IDR ${formatNumber(debtAmount)}")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Deceased's Bequest")),
                    DataCell(Text("IDR ${formatNumber(testamentAmount)}")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Funeral Arrangement")),
                    DataCell(Text("IDR ${formatNumber(funeralAmount)}")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Net Property")),
                    DataCell(Text("IDR ${formatNumber(totalProperty)}")),
                  ]),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Total Share",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Text(
                "Total share is the sum of all shares of the heirs entitled to receive a share. Division status for this case is $divisionStatus.",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 10),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Heir')),
                  DataColumn(label: Text('Portion')),
                  DataColumn(label: Text('Inheritance')),
                ],
                rows: filteredHeirs.entries
                    .where((entry) => entry.value > 0)
                    .map((entry) {
                  return DataRow(cells: [
                    DataCell(Text(entry.key)),
                    DataCell(Text(portions[entry.key].toString())),
                    DataCell(Text(
                        "IDR ${formatNumber(distribution[entry.key] ?? 0)}")),
                  ]);
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                "Final Share: ${filteredHeirs.values.fold(0, (sum, count) => sum + count)}/$finalShare",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
