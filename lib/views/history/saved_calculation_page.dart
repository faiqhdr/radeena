import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';

class SavedCalculationPage extends StatelessWidget {
  final Map<String, dynamic> calculation;

  const SavedCalculationPage({Key? key, required this.calculation})
      : super(key: key);

  String formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
  }

  Map<String, int> parseSelectedHeirs(String selectedHeirsString) {
    return Map.fromEntries(
      selectedHeirsString
          .substring(1, selectedHeirsString.length - 1)
          .split(', ')
          .map((entry) {
        final parts = entry.split(': ');
        return MapEntry(parts[0], int.parse(parts[1]));
      }),
    );
  }

  Map<String, double> parseDistribution(String distributionString) {
    return Map.fromEntries(
      distributionString
          .substring(1, distributionString.length - 1)
          .split(', ')
          .map((entry) {
        final parts = entry.split(': ');
        return MapEntry(parts[0], double.parse(parts[1]));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Map<String, int> selectedHeirs =
        parseSelectedHeirs(calculation['selectedHeirs']);
    Map<String, double> distribution =
        parseDistribution(calculation['distribution']);

    Map<String, dynamic> portions = {
      'Father': '1/6',
      'Mother': (selectedHeirs.containsKey('Son') ||
              selectedHeirs.containsKey('Daughter'))
          ? '1/6'
          : '1/3',
      'Husband': (selectedHeirs.containsKey('Son') ||
              selectedHeirs.containsKey('Daughter'))
          ? '1/4'
          : '1/2',
      'Wife': (selectedHeirs.containsKey('Son') ||
              selectedHeirs.containsKey('Daughter'))
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
      'Sister': selectedHeirs['Sister'] == 1
          ? '1/2'
          : selectedHeirs['Sister'] != null && selectedHeirs['Sister']! > 1
              ? '2/3'
              : 'Residue',
      'Maternal Half Brother': 'Residue',
      'Maternal Half Sister': selectedHeirs['Maternal Half Sister'] == 1
          ? '1/2'
          : selectedHeirs['Maternal Half Sister'] != null &&
                  selectedHeirs['Maternal Half Sister']! > 1
              ? '2/3'
              : 'Residue',
      'Paternal Half Brother': 'Residue',
      'Paternal Half Sister': selectedHeirs['Paternal Half Sister'] == 1
          ? '1/2'
          : selectedHeirs['Paternal Half Sister'] != null &&
                  selectedHeirs['Paternal Half Sister']! > 1
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
          "History",
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
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  calculation['calculationName'],
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
                    DataCell(Text(
                        "IDR ${formatNumber(calculation['propertyAmount'])}")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Deceased's Debt")),
                    DataCell(
                        Text("IDR ${formatNumber(calculation['debtAmount'])}")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Deceased's Bequest")),
                    DataCell(Text(
                        "IDR ${formatNumber(calculation['testamentAmount'])}")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Funeral Arrangement")),
                    DataCell(Text(
                        "IDR ${formatNumber(calculation['funeralAmount'])}")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Net Property")),
                    DataCell(Text(
                        "IDR ${formatNumber(calculation['totalProperty'])}")),
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
                "Total share is the sum of all shares of the heirs entitled to receive a share. Division status for this case is ${calculation['divisionStatus']}.",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 10),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Heir')),
                  DataColumn(label: Text('Portion')),
                  DataColumn(label: Text('Inheritance')),
                ],
                rows: selectedHeirs.entries
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
                "Final Share: ${selectedHeirs.values.fold(0, (sum, count) => sum + count)}/${calculation['finalShare']}",
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
