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

  Map<String, List<String>> familyRelations = {
    'Father': ['Son', 'Daughter'],
    'Mother': ['Son', 'Daughter'],
    'Son': ['Grandson', 'Granddaughter'],
    'Daughter': [],
    'Brother': ['Son of Brother'],
    'Son of Brother': [],
    // Add other relationships as needed
  };

  Map<String, int> getImpediments() {
    final Map<String, int> impediments = {};

    if ((heirQuantity['Father'] ?? 0) > 0) {
      impediments[
          'Paternal Grandfather is impeded because the Father is present.'] = 0;
    }

    if ((heirQuantity['Mother'] ?? 0) > 0) {
      impediments[
          'Maternal Grandmother is impeded because the Mother is present.'] = 0;
    }

    if ((heirQuantity['Father'] ?? 0) > 0 ||
        (heirQuantity['Paternal Grandfather'] ?? 0) > 0 ||
        (heirQuantity['Son'] ?? 0) > 0 ||
        (heirQuantity['Grandson'] ?? 0) > 0) {
      impediments[
          'Brother is impeded due to the presence of direct male descendants or the Father.'] = 0;
    }

    if ((heirQuantity['Grandfather'] ?? 0) > 0 ||
        (heirQuantity['Father'] ?? 0) > 0 ||
        (heirQuantity['Son'] ?? 0) > 0 ||
        (heirQuantity['Daughter'] ?? 0) > 0 ||
        (heirQuantity['Grandson'] ?? 0) > 0 ||
        (heirQuantity['Granddaughter'] ?? 0) > 0) {
      impediments[
          'Maternal Half Brother is impeded because of the presence of direct descendants or the Grandfather.'] = 0;
    }

    if ((heirQuantity['Father'] ?? 0) > 0 ||
        (heirQuantity['Son'] ?? 0) > 0 ||
        (heirQuantity['Maternal Half Brother'] ?? 0) > 0 ||
        (heirQuantity['Daughter'] ?? 0) > 0 ||
        (heirQuantity['Grandson'] ?? 0) > 0 ||
        (heirQuantity['Granddaughter'] ?? 0) > 0) {
      impediments[
          'Paternal Half Brother is impeded because other direct descendants are present.'] = 0;
    }

    return impediments;
  }

  void updateHeirQuantity(String heir, int quantity) {
    heirQuantity[heir] = quantity;
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
    familyRelations.forEach((parent, children) {
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
