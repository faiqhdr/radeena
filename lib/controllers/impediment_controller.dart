import 'package:graphview/GraphView.dart';

class ImpedimentController {
  Map<String, int> heirQuantity = {
    'Father': 0,
    'Mother': 0,
    'Paternal Grandfather': 0,
    'Paternal Grandmother': 0,
    'Maternal Grandmother': 0,
    'Wife': 0,
    'Husband': 0,
    'Son': 0,
    'Daughter': 0,
    'Grandson': 0,
    'Granddaughter': 0,
    'Brother': 0,
    'Sister': 0,
    'Paternal Half Brother': 0,
    'Paternal Half Sister': 0,
    'Maternal Half Brother': 0,
    'Maternal Half Sister': 0,
    'Son of Brother': 0,
    'Son of Paternal Half Brother': 0,
    'Uncle': 0,
    'Paternal Uncle': 0,
    'Son of Uncle': 0,
    'Son of Paternal Uncle': 0,
  };

  Map<String, List<String>> impedimentRules = {
    'Grandson': ['Son'],
    'Paternal Grandfather': ['Father', 'Maternal Grandfather'],
    'Brother': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather'
    ],
    'Paternal Half Brother': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Sister'
    ],
    'Maternal Half Brother': [
      'Son',
      'Daughter',
      'Grandson',
      'Granddaughter',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather'
    ],
    'Son of Brother': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Paternal Half Brother',
      'Sister',
      'Paternal Half Sister'
    ],
    'Son of Paternal Half Brother': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Paternal Half Brother',
      'Sister',
      'Paternal Half Sister',
      'Son of Brother'
    ],
    'Uncle': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Paternal Half Brother',
      'Sister',
      'Paternal Half Sister',
      'Son of Brother',
      'Son of Paternal Half Brother'
    ],
    'Paternal Uncle': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Paternal Half Brother',
      'Sister',
      'Paternal Half Sister',
      'Son of Brother',
      'Son of Paternal Half Brother',
      'Uncle'
    ],
    'Son of Uncle': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Paternal Half Brother',
      'Sister',
      'Paternal Half Sister',
      'Son of Brother',
      'Son of Paternal Half Brother',
      'Uncle',
      'Paternal Uncle'
    ],
    'Son of Paternal Uncle': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Paternal Half Brother',
      'Sister',
      'Paternal Half Sister',
      'Son of Brother',
      'Son of Paternal Half Brother',
      'Uncle',
      'Son of Uncle'
    ],
    'Granddaughter': ['Son', 'Daughter'],
    'Paternal Grandmother': ['Mother'],
    'Maternal Grandmother': ['Mother'],
    'Sister': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather'
    ],
    'Paternal Half Sister': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Sister',
      'Paternal Half Brother'
    ],
    'Maternal Half Sister': [
      'Son',
      'Daughter',
      'Grandson',
      'Granddaughter',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather'
    ],
    'Male/Female Slave Emancipator': [
      'Father',
      'Mother',
      'Paternal Grandfather',
      'Paternal Grandmother',
      'Maternal Grandmother',
      'Wife',
      'Husband',
      'Son',
      'Daughter',
      'Grandson',
      'Granddaughter',
      'Brother',
      'Sister',
      'Paternal Half Brother',
      'Paternal Half Sister',
      'Maternal Half Brother',
      'Maternal Half Sister',
      'Son of Brother',
      'Son of Paternal Half Brother',
      'Uncle',
      'Paternal Uncle',
      'Son of Uncle',
      'Son of Paternal Uncle'
    ],
  };

  List<String> getImpediments() {
    List<String> impediments = [];

    heirQuantity.forEach((heir, count) {
      if (count > 0 && impedimentRules.containsKey(heir)) {
        for (var rule in impedimentRules[heir]!) {
          if ((heirQuantity[rule] ?? 0) > 0) {
            impediments.add('$heir is impeded because $rule is present.');
            break;
          }
        }
      }
    });

    return impediments;
  }

  void updateHeirQuantity(String heir, int quantity) {
    heirQuantity[heir] = quantity;
  }

  Map<String, int> getFilteredHeirs(Map<String, int> selectedHeirs) {
    Map<String, int> filteredHeirs = {};
    List<String> impediments = getImpediments().map((impediment) {
      return impediment.split(' is impeded')[0];
    }).toList();

    selectedHeirs.forEach((heir, count) {
      if (!impediments.contains(heir) && count > 0) {
        filteredHeirs[heir] = count;
      }
    });

    return filteredHeirs;
  }

  Graph buildGraph() {
    Graph graph = Graph()..isTree = true;
    Map<String, Node> nodes = {};
    heirQuantity.forEach((heir, count) {
      if (count > 0) {
        Node node = Node.Id(heir);
        nodes[heir] = node;
        graph.addNode(node);
      }
    });

    // Add edges based on relationships
    impedimentRules.forEach((parent, children) {
      if (nodes.containsKey(parent)) {
        children.forEach((child) {
          if (nodes.containsKey(child)) {
            graph.addEdge(nodes[parent]!, nodes[child]!);
          }
        });
      }
    });

    return graph;
  }
}
