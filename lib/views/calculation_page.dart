import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/controllers/calculation_controller.dart';

class CalculationPage extends StatelessWidget {
  final double totalProperty;
  final Map<String, int> selectedHeirs;

  const CalculationPage({
    Key? key,
    required this.totalProperty,
    required this.selectedHeirs,
  }) : super(key: key);

  String formatNumber(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    CalculationController controller = CalculationController();
    var result = controller.calculateInheritance(totalProperty, selectedHeirs);
    Map<String, double> distribution = result['distribution'];
    String divisionStatus = result['divisionStatus'];

    List<DataRow> heirRows = selectedHeirs.entries
        .where((entry) => entry.value > 0)
        .map((entry) => DataRow(
              cells: [
                DataCell(Text(entry.key)),
                DataCell(Text(entry.value.toString())),
                DataCell(Text(formatNumber(distribution[entry.key] ?? 0))),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  "Inheritance Distribution",
                  style: textUnderTitleStyle(),
                ),
              ),
              SizedBox(height: 20),
              Text("Net Property: ${formatNumber(totalProperty)} IDR"),
              Text("Division Status: $divisionStatus"),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Heir')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Inheritance')),
                ],
                rows: heirRows,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text("See Calculation Steps"),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Logic to save or further process the results
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text("Save Result"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
