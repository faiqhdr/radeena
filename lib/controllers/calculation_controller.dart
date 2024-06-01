class CalculationController {
  int lcm(int a, int b) {
    return (a * b) ~/ gcd(a, b);
  }

  int gcd(int a, int b) {
    if (b == 0) {
      return a;
    }
    return gcd(b, a % b);
  }

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
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Daughter': {
        'portion': 'Residue',
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
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Sister': {
        'portion': selectedHeirs['Sister'] == 1
            ? 1 / 2
            : selectedHeirs['Sister'] != null && selectedHeirs['Sister']! > 1
                ? 2 / 3
                : 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Maternal Half Brother': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Maternal Half Sister': {
        'portion': selectedHeirs['Maternal Half Sister'] == 1
            ? 1 / 2
            : selectedHeirs['Maternal Half Sister'] != null &&
                    selectedHeirs['Maternal Half Sister']! > 1
                ? 2 / 3
                : 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Paternal Half Brother': {
        'portion': 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Paternal Half Sister': {
        'portion': selectedHeirs['Paternal Half Sister'] == 1
            ? 1 / 2
            : selectedHeirs['Paternal Half Sister'] != null &&
                    selectedHeirs['Paternal Half Sister']! > 1
                ? 2 / 3
                : 'Residue',
        'type': 'Residuary',
        'status': 'ResiduaryByBlood'
      },
      'Son of Paternal Half Brother': {
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

    // Calculate LCM of denominators for applicable Quranic portions
    List<int> denominators = applicablePortions.values
        .where((data) => data['portion'] is double)
        .map((data) => 1 ~/ data['portion'])
        .toList();

    int lcmValue = denominators.fold(1, (prev, denom) => lcm(prev, denom));

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
          applicablePortions[heir]['portion'] == 'residue') {
        totalResiduaryShares += (heir == 'Son' ? 2 * count : count);
      }
    });

    selectedHeirs.forEach((heir, count) {
      if (applicablePortions[heir] != null &&
          applicablePortions[heir]['portion'] == 'residue') {
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

    String divisionStatus = "No Aul / Radd";
    if (totalInitialShares == 1) {
      divisionStatus = "Aul";
    } else if (totalInitialShares < 1) {
      divisionStatus = "Radd";
    }

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
