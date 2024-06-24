import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:radeena/models/deceased_model.dart';

class ImpedimentController {
  final DeceasedModel deceased;
  ImpedimentController(this.deceased);

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
    'Paternal Half-Brother': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Sister'
    ],
    'Maternal Half-Brother': [
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
      'Paternal Half-Brother',
      'Sister',
      'Paternal Half-Sister'
    ],
    'Son of Paternal Half-Brother': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Paternal Half-Brother',
      'Sister',
      'Paternal Half-Sister',
      'Son of Brother'
    ],
    'Uncle': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Paternal Half-Brother',
      'Sister',
      'Paternal Half-Sister',
      'Son of Brother',
      'Son of Paternal Half-Brother'
    ],
    'Paternal Uncle': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Brother',
      'Paternal Half-Brother',
      'Sister',
      'Paternal Half-Sister',
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
      'Paternal Half-Brother',
      'Sister',
      'Paternal Half-Sister',
      'Son of Brother',
      'Son of Paternal Half-Brother',
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
      'Paternal Half-Brother',
      'Sister',
      'Paternal Half-Sister',
      'Son of Brother',
      'Son of Paternal Half-Brother',
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
    'Paternal Half-Sister': [
      'Son',
      'Grandson',
      'Father',
      'Paternal Grandfather',
      'Maternal Grandfather',
      'Sister',
      'Paternal Half-Brother'
    ],
    'Maternal Half-Sister': [
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
      'Paternal Half-Brother',
      'Paternal Half-Sister',
      'Maternal Half-Brother',
      'Maternal Half-Sister',
      'Son of Brother',
      'Son of Paternal Half-Brother',
      'Uncle',
      'Paternal Uncle',
      'Son of Uncle',
      'Son of Paternal Uncle'
    ],
  };

  List<String> getImpediments() {
    List<String> impediments = [];

    deceased.heirs.forEach((heir, count) {
      if (count > 0 && impedimentRules.containsKey(heir)) {
        for (var rule in impedimentRules[heir]!) {
          if ((deceased.heirs[rule] ?? 0) > 0) {
            impediments.add(
                '$heir is impeded because $rule is present. Means, $heir can\'t inherit.');
            break;
          }
        }
      }
    });

    return impediments;
  }

  void updateHeirQuantity(String heir, int quantity) {
    deceased.updateHeirQuantity(heir, quantity);
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

  Graph buildGraph(String? deceasedGender) {
    Graph graph = Graph()..isTree = true;
    Map<String, Node> nodes = {};
    Node deceasedNode = Node.Id('Deceased');
    nodes['Deceased'] = deceasedNode;
    graph.addNode(deceasedNode);

    deceased.heirs.forEach((heir, count) {
      Node node = Node.Id(heir);
      nodes[heir] = node;
      graph.addNode(node);
      print('Added node for: $heir');
    });

    if (deceasedGender == 'Male') {
      addEdge(graph, nodes, 'Deceased', 'Wife');
    } else {
      addEdge(graph, nodes, 'Deceased', 'Husband');
    }

    addEdge(graph, nodes, 'Paternal Grandfather', 'Father');
    addEdge(graph, nodes, 'Paternal Grandmother', 'Father');
    addEdge(graph, nodes, 'Maternal Grandfather', 'Mother');
    addEdge(graph, nodes, 'Maternal Grandmother', 'Mother');
    addEdge(graph, nodes, 'Father', 'Deceased');
    addEdge(graph, nodes, 'Mother', 'Deceased');
    addEdge(graph, nodes, 'Deceased', 'Son');
    addEdge(graph, nodes, 'Deceased', 'Daughter');
    addEdge(graph, nodes, 'Son', 'Grandson');
    addEdge(graph, nodes, 'Son', 'Granddaughter');

    addEdge(graph, nodes, 'Father', 'Brother');
    addEdge(graph, nodes, 'Father', 'Sister');
    addEdge(graph, nodes, 'Father', 'Paternal Half-Brother');
    addEdge(graph, nodes, 'Father', 'Paternal Half-Sister');
    addEdge(graph, nodes, 'Mother', 'Maternal Half-Brother');
    addEdge(graph, nodes, 'Mother', 'Maternal Half-Sister');

    addEdge(graph, nodes, 'Paternal Grandfather', 'Uncle');
    addEdge(graph, nodes, 'Paternal Grandfather', 'Paternal Uncle');
    addEdge(graph, nodes, 'Uncle', 'Son of Uncle');
    addEdge(graph, nodes, 'Paternal Uncle', 'Son of Paternal Uncle');
    addEdge(graph, nodes, 'Brother', 'Son of Brother');
    addEdge(
        graph, nodes, 'Paternal Half-Brother', 'Son of Paternal Half-Brother');

    return graph;
  }

  void addEdge(Graph graph, Map<String, Node> nodes, String from, String to) {
    if (nodes.containsKey(from) && nodes.containsKey(to)) {
      graph.addEdge(nodes[from]!, nodes[to]!);
      print('Added edge from $from to $to');
    }
  }

  LinearGradient getNodeGradient(String heir) {
    if (heir == 'Deceased') {
      return LinearGradient(
        colors: [Colors.blue.shade600, Colors.blue.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    if (deceased.heirs[heir] == 0) {
      return LinearGradient(
        colors: [Colors.grey.shade500, Colors.grey.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    if (getImpediments().any((imp) => imp.startsWith(heir))) {
      return LinearGradient(
        colors: [Colors.red.shade600, Colors.red.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return LinearGradient(
      colors: [Colors.green.shade600, Colors.green.shade400],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
