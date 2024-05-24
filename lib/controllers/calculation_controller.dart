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
        'portion': 'residue',
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

    // Calculate initial shares based on fixed portions
    Map<String, double> initialShares = {};
    double totalInitialShares = 0;
    portions.forEach((heir, data) {
      double portion =
          data != null && data['portion'] is double ? data['portion'] : 0.0;
      if (selectedHeirs.containsKey(heir) && portion != 0.0) {
        initialShares[heir] = portion;
        totalInitialShares += portion;
      }
    });

    // Calculate the total property proportion to distribute based on the initial shares
    double assignedProperty = 0.0;
    Map<String, double> distribution = {};
    initialShares.forEach((heir, portion) {
      double share = totalProperty * portion;
      distribution[heir] = share;
      assignedProperty += share;
    });

    // Calculate the residue
    double residue = totalProperty - assignedProperty;

    // Calculate total residue shares for sons and daughters
    int totalResiduaryShares = 0;
    selectedHeirs.forEach((heir, count) {
      if (portions[heir] != null && portions[heir]['portion'] == 'residue') {
        totalResiduaryShares += (heir == 'Son' ? 2 * count : count);
      }
    });

    // Distribute the residue
    selectedHeirs.forEach((heir, count) {
      if (portions[heir] != null && portions[heir]['portion'] == 'residue') {
        double share = residue *
            ((heir == 'Son' ? 2 * count : count) / totalResiduaryShares);
        distribution[heir] = (distribution[heir] ?? 0) + share;
      }
    });

    // Ensure all shares are positive
    distribution.forEach((heir, share) {
      if (share < 0) {
        distribution[heir] = -share;
      }
    });

    return {
      'distribution': distribution,
      'totalInitialShares': totalInitialShares,
      'initialShares': initialShares,
      'divisionStatus': totalInitialShares > 1
          ? "Aul"
          : totalInitialShares < 1
              ? "Radd"
              : "None",
    };

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
}
