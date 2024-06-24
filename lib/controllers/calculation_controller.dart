import 'package:radeena/models/calculation_model.dart';

class CalculationController {
  final CalculationModel model = CalculationModel();

  Future<void> saveCalculation(
    String calculationName,
    double totalProperty,
    double propertyAmount,
    double debtAmount,
    double testamentAmount,
    double funeralAmount,
    Map<String, int> selectedHeirs,
    Map<String, double> distribution,
    String divisionStatus,
    int finalShare,
  ) async {
    await model.saveCalculation(
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
  }

  int lcm(int a, int b) {
    return (a * b) ~/ gcd(a, b);
  }

  int gcd(int a, int b) {
    if (b == 0) {
      return a;
    }
    return gcd(b, a % b);
  }

  int calculateLCM(List<int> numbers) {
    if (numbers.isEmpty) return 1;
    return numbers.reduce((a, b) => lcm(a, b));
  }

  Map<String, dynamic> calculateInheritance(
      double totalProperty, Map<String, int> selectedHeirs) {
    if (selectedHeirs.isEmpty) {
      return {
        'distribution': {'Kinsfolk or Baitul Maal': totalProperty},
        'totalInitialShares': 0.0,
        'initialShares': {},
        'divisionStatus':
            "All the inheritance will be given to kinsfolk or Baitul Maal.",
        'finalShare': 1
      };
    }

    // Define the portion each heir receives based on Islamic law
    Map<String, dynamic> portions = {
      'Father': {
        'portion': (selectedHeirs.containsKey('Son') ||
                selectedHeirs.containsKey('Daughter') ||
                selectedHeirs.containsKey('Grandson') ||
                selectedHeirs.containsKey('Granddaughter'))
            ? 1 / 6
            : (selectedHeirs.containsKey('Mother')
                ? 'DoubleMother'
                : 'Residue'),
        'type': 'Quranic',
        'status': 'Primary'
      },
      'Mother': {
        'portion': (selectedHeirs.containsKey('Son') ||
                selectedHeirs.containsKey('Daughter') ||
                selectedHeirs.containsKey('Grandson') ||
                selectedHeirs.containsKey('Granddaughter') ||
                selectedHeirs.containsKey('Brother') ||
                selectedHeirs.containsKey('Sister') ||
                selectedHeirs.containsKey('Paternal Half-Brother') ||
                selectedHeirs.containsKey('Paternal Half-Sister') ||
                selectedHeirs.containsKey('Maternal Half-Brother') ||
                selectedHeirs.containsKey('Maternal Half-Sister'))
            ? 1 / 6
            : (selectedHeirs.keys.toSet().difference(
                    {'Father', 'Mother', 'Husband', 'Wife'}).isEmpty)
                ? 'Residue'
                : 1 / 3,
        'type': 'Quranic',
        'status': 'Primary'
      },
      'Husband': {
        'portion': (selectedHeirs.containsKey('Son') ||
                selectedHeirs.containsKey('Daughter') ||
                selectedHeirs.containsKey('Grandson') ||
                selectedHeirs.containsKey('Granddaughter'))
            ? 1 / 4
            : 1 / 2,
        'type': 'Quranic',
        'status': 'Primary'
      },
      'Wife': {
        'portion': (selectedHeirs.containsKey('Son') ||
                selectedHeirs.containsKey('Daughter') ||
                selectedHeirs.containsKey('Grandson') ||
                selectedHeirs.containsKey('Granddaughter'))
            ? 1 / 8
            : 1 / 4,
        'type': 'Quranic',
        'status': 'Primary'
      },
      'Son': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Daughter': {
        'portion': selectedHeirs.containsKey('Son')
            ? 'Residue'
            : (selectedHeirs['Daughter'] == 1
                ? 1 / 2
                : (selectedHeirs['Daughter'] != null &&
                        selectedHeirs['Daughter']! > 1)
                    ? 2 / 3
                    : 'Residue'),
        'type': 'Quranic',
        'status': 'Substitute'
      },
      'Grandson': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'Substitute'
      },
      'Granddaughter': {
        'portion': selectedHeirs.containsKey('Grandson')
            ? 'Residue'
            : (selectedHeirs['Granddaughter'] == 1
                ? 1 / 2
                : (selectedHeirs['Granddaughter'] != null &&
                        selectedHeirs['Granddaughter']! > 1)
                    ? 2 / 3
                    : 'Residue'),
        'type': 'Quranic',
        'status': 'Substitute'
      },
      'Paternal Grandfather': {
        'portion': (selectedHeirs.containsKey('Son') ||
                selectedHeirs.containsKey('Daughter') ||
                selectedHeirs.containsKey('Grandson') ||
                selectedHeirs.containsKey('Granddaughter'))
            ? 1 / 6
            : 'Residue',
        'type': 'Quranic',
        'status': 'Substitute'
      },
      'Paternal Grandmother': {
        'portion': (selectedHeirs.containsKey('Son') ||
                selectedHeirs.containsKey('Daughter') ||
                selectedHeirs.containsKey('Grandson') ||
                selectedHeirs.containsKey('Granddaughter'))
            ? 1 / 6
            : 'Residue',
        'type': 'Quranic',
        'status': 'Substitute'
      },
      'Maternal Grandmother': {
        'portion': (selectedHeirs.containsKey('Son') ||
                selectedHeirs.containsKey('Daughter') ||
                selectedHeirs.containsKey('Grandson') ||
                selectedHeirs.containsKey('Granddaughter'))
            ? 1 / 6
            : 'Residue',
        'type': 'Quranic',
        'status': 'Substitute'
      },
      'Brother': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Sister': {
        'portion': selectedHeirs['Sister'] == 1
            ? 1 / 2
            : (selectedHeirs['Sister'] != null && selectedHeirs['Sister']! > 1)
                ? 2 / 3
                : 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Maternal Half-Brother': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Maternal Half-Sister': {
        'portion': selectedHeirs['Maternal Half-Sister'] == 1
            ? 1 / 2
            : (selectedHeirs['Maternal Half-Sister'] != null &&
                    selectedHeirs['Maternal Half-Sister']! > 1)
                ? 2 / 3
                : 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Paternal Half-Brother': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Paternal Half-Sister': {
        'portion': selectedHeirs['Paternal Half-Sister'] == 1
            ? 1 / 2
            : (selectedHeirs['Paternal Half-Sister'] != null &&
                    selectedHeirs['Paternal Half-Sister']! > 1)
                ? 2 / 3
                : 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Son of Paternal Half-Brother': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Uncle': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Paternal Uncle': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Son of Paternal Uncle': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Son of Uncle': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      }
    };

    // Filter out heirs not present in selectedHeirs
    Map<String, dynamic> applicablePortions = {};
    portions.forEach((heir, data) {
      if (selectedHeirs.containsKey(heir)) {
        applicablePortions[heir] = data;
      }
    });

    // If all selected heirs have "Residue" portion, assign all property to them
    bool onlyResidueHeirs = applicablePortions.values.every((data) =>
        data['portion'] == 'Residue' || data['portion'] == 'DoubleMother');
    if (onlyResidueHeirs) {
      Map<String, double> allResidueDistribution = {};
      selectedHeirs.forEach((heir, count) {
        allResidueDistribution[heir] = totalProperty;
      });
      return {
        'distribution': allResidueDistribution,
        'totalInitialShares': 0.0,
        'initialShares': {},
        'divisionStatus': "All the property is given to the residuary heirs.",
        'finalShare': 1
      };
    }

    // Calculate LCM of denominators for applicable Quranic portions
    List<int> denominators = applicablePortions.values
        .where((data) => data['portion'] is double)
        .map((data) => 1 ~/ data['portion'])
        .toList();

    int lcmValue = calculateLCM(denominators);

    // Calculate initial shares based on fixed portions
    Map<String, double> initialShares = {};
    double totalInitialShares = 0;

    applicablePortions.forEach((heir, data) {
      if (data['portion'] is double) {
        double portion = data['portion'];
        initialShares[heir] = portion;
        totalInitialShares += portion;
      }
    });

    double assignedProperty = 0.0;
    Map<String, double> distribution = {};

    initialShares.forEach((heir, portion) {
      double share = totalProperty * portion;
      distribution[heir] = share;
      assignedProperty += share;
    });

    double residue = totalProperty - assignedProperty;
    int totalResiduaryShares = 0;

    selectedHeirs.forEach((heir, count) {
      if (applicablePortions[heir] != null &&
          applicablePortions[heir]['portion'] == 'Residue') {
        totalResiduaryShares += (heir == 'Son' ||
                heir == 'Brother' ||
                heir == 'Maternal Half-Brother' ||
                heir == 'Paternal Half-Brother' ||
                heir == 'Son of Paternal Half-Brother' ||
                heir == 'Uncle' ||
                heir == 'Paternal Uncle' ||
                heir == 'Son of Paternal Uncle' ||
                heir == 'Son of Uncle'
            ? 2 * count
            : count);
      } else if (applicablePortions[heir] != null &&
          applicablePortions[heir]['portion'] == 'DoubleMother') {
        totalResiduaryShares += 2 * selectedHeirs['Mother']!;
      }
    });

    selectedHeirs.forEach((heir, count) {
      if (applicablePortions[heir] != null &&
          applicablePortions[heir]['portion'] == 'Residue') {
        double share = residue *
            ((heir == 'Son' ||
                        heir == 'Brother' ||
                        heir == 'Maternal Half-Brother' ||
                        heir == 'Paternal Half-Brother' ||
                        heir == 'Son of Paternal Half-Brother' ||
                        heir == 'Uncle' ||
                        heir == 'Paternal Uncle' ||
                        heir == 'Son of Paternal Uncle' ||
                        heir == 'Son of Uncle'
                    ? 2 * count
                    : count) /
                totalResiduaryShares);
        distribution[heir] = (distribution[heir] ?? 0) + share;
      } else if (applicablePortions[heir] != null &&
          applicablePortions[heir]['portion'] == 'DoubleMother') {
        double share =
            residue * (2 * selectedHeirs['Mother']! / totalResiduaryShares);
        distribution[heir] = (distribution[heir] ?? 0) + share;
      }
    });

    // Ensure all shares are positive
    distribution.forEach((heir, share) {
      if (share < 0) {
        distribution[heir] = -share;
      }
    });

    String divisionStatus = "Unavailable";
    if (totalInitialShares > 1) {
      divisionStatus = "Aul / Radd";
    } else if (totalInitialShares < 1) {
      divisionStatus = "No Aul / Radd";
    }

    // Check for residue
    // if (residue > 0 && totalResiduaryShares > 0) {
    //   divisionStatus +=
    //       "\nThere is residue that can be distributed to the relatives.";
    // }

    // Correcting final share value calculation
    int finalShare = lcmValue;

    return {
      'distribution': distribution,
      'totalInitialShares': totalInitialShares,
      'initialShares': initialShares,
      'divisionStatus': divisionStatus,
      'finalShare': finalShare
    };
  }
}
