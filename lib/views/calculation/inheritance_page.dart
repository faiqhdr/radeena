import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';
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
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}.");
  }

  String getCalculationSteps(Map<String, dynamic> portions,
      Map<String, int> filteredHeirs, double totalProperty) {
    StringBuffer steps = StringBuffer();

    // Calculate the LCM
    List<int> denominators = filteredHeirs.entries
        .where((entry) => portions[entry.key] != 'Residue')
        .map((entry) => int.parse(portions[entry.key].split('/')[1]))
        .toList();

    int lcm = denominators.fold(
        1, (prev, element) => prev * element ~/ gcd(prev, element));
    steps.writeln("1. Least Common Multiple (LCM) Calculation:");
    steps.writeln("   - Determine the LCM of the denominators.");
    denominators.forEach(
        (denominator) => steps.writeln("   - Denominator: $denominator"));
    steps.writeln("   - LCM: ${denominators.join(' x ')} = $lcm");

    // Individual calculations
    Map<String, double> individualShares = {};
    filteredHeirs.forEach((heir, count) {
      if (portions[heir] != 'Residue') {
        int numerator = int.parse(portions[heir].split('/')[0]);
        int denominator = int.parse(portions[heir].split('/')[1]);
        double share = totalProperty * numerator / denominator;

        individualShares[heir] = share;

        steps.writeln("\n${heir}'s Portion:");
        steps.writeln("   - Portion = ${portions[heir]}");
        steps.writeln(
            "   - Convert to common denominator: ${numerator} x $lcm / $denominator = ${numerator * lcm / denominator}/$lcm");
        steps.writeln(
            "   - Calculation: $numerator/$denominator x ${formatNumber(totalProperty)}");
        steps.writeln("   - Result: IDR ${formatNumber(share)}");
      }
    });

    // Residual calculation
    double totalDistributed =
        individualShares.values.fold(0.0, (sum, value) => sum + value);
    double residue = totalProperty - totalDistributed;
    steps.writeln("\n2. Residual calculation:");
    steps.writeln(
        "   - Total distributed: IDR ${formatNumber(totalDistributed)}");
    steps.writeln(
        "   - Residue: ${formatNumber(totalProperty)} - ${formatNumber(totalDistributed)} = IDR ${formatNumber(residue)}");

    // Residual heirs
    List<String> residualHeirs = filteredHeirs.entries
        .where((entry) => portions[entry.key] == 'Residue')
        .map((entry) => entry.key)
        .toList();

    if (residualHeirs.isNotEmpty) {
      int maleHeirsCount = filteredHeirs['Son'] ?? 0;
      int femaleHeirsCount = filteredHeirs['Daughter'] ?? 0;
      int totalParts = maleHeirsCount * 2 + femaleHeirsCount;
      double maleShare = residue * 2 / totalParts;
      double femaleShare = residue / totalParts;

      residualHeirs.forEach((heir) {
        if (heir == 'Son') {
          steps.writeln(
              "\n${heir} = Get the residue, because male will get twice of female, then the portion is:");
          steps.writeln("   - Residue x 2/3 = ${formatNumber(residue)} x 2/3");
          steps.writeln(
              "   - Result: IDR ${formatNumber(maleShare)} each ${heir}");
        } else if (heir == 'Daughter') {
          steps.writeln(
              "\n${heir} = Get the residue, because male will get twice of female, then the portion is:");
          steps.writeln("   - Residue x 1/3 = ${formatNumber(residue)} x 1/3");
          steps.writeln(
              "   - Result: IDR ${formatNumber(femaleShare)} each daughter");
        } else {
          double share = residue / residualHeirs.length;
          steps.writeln("\n${heir} = Get the residue:");
          steps.writeln("   - Residue / ${residualHeirs.length}");
          steps.writeln(
              "   - Result: IDR ${formatNumber(share)} each (${filteredHeirs[heir]} ${heir.toLowerCase()}(s))");
        }
      });
    }

    return steps.toString();
  }

  int gcd(int a, int b) {
    while (b != 0) {
      int t = b;
      b = a % b;
      a = t;
    }
    return a;
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

    String calculationSteps =
        getCalculationSteps(portions, filteredHeirs, totalProperty);

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
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  "Distribution Detail",
                  style: textUnderTitleStyle(),
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 123, vertical: 7),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(0.7),
                      secondaryColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Property Details",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.7),
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.1),
                        Colors.grey.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: DataTable(
                    columns: const [
                      DataColumn(
                          label: Text(
                        'Property',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Amount',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text(
                          "Total Property",
                          style: TextStyle(color: Colors.teal.shade800),
                        )),
                        DataCell(Text(
                          "IDR ${formatNumber(propertyAmount)}",
                          style: TextStyle(color: Colors.teal.shade800),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          "Deceased's Debt",
                          style: TextStyle(color: Colors.teal.shade800),
                        )),
                        DataCell(Text(
                          "IDR ${formatNumber(debtAmount)}",
                          style: TextStyle(color: Colors.teal.shade800),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          "Deceased's Testament",
                          style: TextStyle(color: Colors.teal.shade800),
                        )),
                        DataCell(Text(
                          "IDR ${formatNumber(testamentAmount)}",
                          style: TextStyle(color: Colors.teal.shade800),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          "Funeral Arrangement",
                          style: TextStyle(color: Colors.teal.shade800),
                        )),
                        DataCell(Text(
                          "IDR ${formatNumber(funeralAmount)}",
                          style: TextStyle(color: Colors.teal.shade800),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          "Net Property",
                          style: TextStyle(
                              color: Colors.teal.shade800,
                              fontWeight: FontWeight.w600),
                        )),
                        DataCell(Text(
                          "IDR ${formatNumber(totalProperty)}",
                          style: TextStyle(
                              color: Colors.teal.shade800,
                              fontWeight: FontWeight.w600),
                        )),
                      ]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 121, vertical: 7),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(0.7),
                      secondaryColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Final Share: ${filteredHeirs.values.fold(0, (sum, count) => sum + count)}/$finalShare",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Final share is the combined shares ($finalShare portions) of all entitled heirs (${filteredHeirs.values.fold(0, (sum, count) => sum + count)} people). Division status for this calculation case is $divisionStatus.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              ),
              SizedBox(height: 15),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.7),
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.1),
                        Colors.grey.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: DataTable(
                    columns: const [
                      DataColumn(
                          label: Text(
                        'Heir',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Portion',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Asset',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                    rows: filteredHeirs.entries
                        .where((entry) => entry.value > 0)
                        .map((entry) {
                      return DataRow(cells: [
                        DataCell(
                          Text(
                            '${entry.value}-${entry.key}(s)',
                            style: TextStyle(
                              color: Colors.teal.shade800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            portions[entry.key].toString(),
                            style: TextStyle(
                              color: Colors.teal.shade800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            "IDR ${formatNumber(distribution[entry.key] ?? 0)}",
                            style: TextStyle(
                              color: Colors.teal.shade800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 119, vertical: 7),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(0.7),
                      secondaryColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Calculation Steps",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.7),
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.1),
                        Colors.grey.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Text(
                    calculationSteps,
                    style: TextStyle(
                        color: Colors.teal.shade800,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
