import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/views/confirmation_page.dart'; // Make sure this import is correct

class TreeGraphPage extends StatelessWidget {
  final IdentificationController identificationController;
  final ImpedimentController impedimentController;

  const TreeGraphPage({
    Key? key,
    required this.identificationController,
    required this.impedimentController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Graph graph = impedimentController.buildGraph();
    BuchheimWalkerConfiguration config = BuchheimWalkerConfiguration()
      ..siblingSeparation = 70
      ..levelSeparation = 90
      ..subtreeSeparation = 10
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    NodeWidgetBuilder builder = (node) {
      bool isImpeded =
          impedimentController.getImpediments().containsKey(node.key?.value);
      return rectangleWidget(
          node.key?.value as String, isImpeded ? Colors.red : Colors.green);
    };

    BuchheimWalkerAlgorithm algorithm = BuchheimWalkerAlgorithm(config, null);

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
          "Family Tree",
          style: titleDetermineHeirsStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "Family Tree Graph",
                style: textUnderTitleStyle(),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: InteractiveViewer(
                constrained: false,
                boundaryMargin: EdgeInsets.all(280),
                minScale: 0.01,
                maxScale: 4.6,
                child: GraphView(
                  graph: graph,
                  algorithm: algorithm,
                  builder: builder,
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(
                      totalProperty:
                          identificationController.property.getTotal(),
                      selectedHeirs: impedimentController.heirQuantity,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }

  Widget rectangleWidget(String label, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
