import 'dart:math';

class CalculationController {
  Map<String, dynamic> calculateInheritance(
      double totalProperty, Map<String, int> selectedHeirs) {
    // Define the portion each heir receives based on Islamic law
    Map<String, dynamic> portions = {
      'Father': {'portion': 1 / 6, 'type': 'Quranic', 'status': 'Primary'},
      'Mother': {
        'portion': (selectedHeirs.containsKey('Son') ||
                selectedHeirs.containsKey('Daughter'))
            ? 1 / 6
            : 1 / 3,
        'type': 'Quranic',
        'status': 'Primary'
      },
      'Husband': {
        'portion': (selectedHeirs.containsKey('Son') ||
                selectedHeirs.containsKey('Daughter'))
            ? 1 / 4
            : 1 / 2,
        'type': 'Quranic',
        'status': 'Primary'
      },
      'Wife': {
        'portion': (selectedHeirs.containsKey('Son') ||
                selectedHeirs.containsKey('Daughter'))
            ? 1 / 8
            : 1 / 4,
        'type': 'Quranic',
        'status': 'Primary'
      },
      'Son': {
        'portion': 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Daughter': {
        'portion': selectedHeirs['Daughter'] == 1
            ? 1 / 2
            : selectedHeirs['Daughter'] != null &&
                    selectedHeirs['Daughter']! > 1
                ? 2 / 3
                : 'residue',
        'type': 'Quranic',
        'status': 'Substitute'
      },
      'Grandson': {
        'portion': 1 / 6,
        'type': 'Residuary',
        'status': 'Substitute'
      },
      'Granddaughter': {
        'portion': 1 / 3,
        'type': 'Residuary',
        'status': 'Substitute'
      },
      'Paternal Grandfather': {
        'portion': 1 / 6,
        'type': 'Quranic',
        'status': 'Substitute'
      },
      'Paternal Grandmother': {
        'portion': 1 / 6,
        'type': 'Quranic',
        'status': 'Substitute'
      },
      'Maternal Grandmother': {
        'portion': 1 / 6,
        'type': 'Quranic',
        'status': 'Substitute'
      },
      'Brother': {
        'portion': 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Sister': {
        'portion': selectedHeirs['Sister'] == 1
            ? 1 / 2
            : selectedHeirs['Sister'] != null && selectedHeirs['Sister']! > 1
                ? 2 / 3
                : 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Maternal Half Brother': {
        'portion': 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Maternal Half Sister': {
        'portion': selectedHeirs['Maternal Half Sister'] == 1
            ? 1 / 2
            : selectedHeirs['Maternal Half Sister'] != null &&
                    selectedHeirs['Maternal Half Sister']! > 1
                ? 2 / 3
                : 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Paternal Half Brother': {
        'portion': 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Paternal Half Sister': {
        'portion': selectedHeirs['Paternal Half Sister'] == 1
            ? 1 / 2
            : selectedHeirs['Paternal Half Sister'] != null &&
                    selectedHeirs['Paternal Half Sister']! > 1
                ? 2 / 3
                : 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Son of Paternal Half Brother': {
        'portion': 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Uncle': {
        'portion': 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Paternal Uncle': {
        'portion': 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Son of Paternal Uncle': {
        'portion': 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Son of Uncle': {
        'portion': 'residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      }
    };

    // Calculating LCM for Quranic heirs
    List<int> denominators = portions.entries
        .where(
            (entry) => entry.value != null && entry.value['portion'] is double)
        .map((entry) => (1 / entry.value['portion']).round())
        .toList();
    int lcm = denominators.isNotEmpty ? denominators.reduce(_lcm) : 1;

    // Calculate initial shares based on LCM
    Map<String, double> initialShares = {};
    double totalInitialShares = 0;
    portions.forEach((heir, data) {
      double portion =
          data != null && data['portion'] is double ? data['portion'] : 0.0;
      if (selectedHeirs.containsKey(heir) && portion != 0.0) {
        double shares = (lcm * portion).roundToDouble();
        initialShares[heir] = shares;
        totalInitialShares += shares;
      }
    });

    // Calculate the total property proportion to distribute based on the LCM
    double propertyShare =
        totalProperty / max(lcm, 1); // Ensure lcm is never zero
    Map<String, double> distribution = {};
    initialShares.forEach((heir, shares) {
      // Safe access to distribution values
      distribution[heir] = shares /
          max(lcm, 1) *
          totalProperty; // Protect against division by zero
    });

    double assignedProperty =
        distribution.values.fold(0.0, (sum, v) => sum + v);
    double residue = totalProperty - assignedProperty;
    double totalResiduaryShares = selectedHeirs.entries
        .where((entry) =>
            portions[entry.key] != null &&
            portions[entry.key]['portion'] == 'residue')
        .fold(
            0,
            (prev, element) =>
                prev +
                (element.value ??
                    0)); // Protect against null values in calculation

    selectedHeirs.forEach((heir, count) {
      if (portions[heir] != null && portions[heir]['portion'] == 'residue') {
        distribution[heir] = (residue *
            (count /
                max(totalResiduaryShares,
                    1))); // Protect against division by zero
      }
    });

    return {
      'distribution': distribution,
      'totalInitialShares': totalInitialShares,
      'initialShares': initialShares,
      'divisionStatus': totalInitialShares > lcm
          ? "Aul"
          : totalInitialShares < lcm
              ? "Radd"
              : "None",
    };
  }

  int _lcm(int a, int b) {
    int greater = max(a, b);
    while (true) {
      if (greater % a == 0 && greater % b == 0) {
        return greater;
      }
      ++greater;
    }
  }
}
