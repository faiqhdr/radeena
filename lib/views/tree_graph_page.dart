import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/views/confirmation_page.dart';

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

    Graph graph = impedimentController
        .buildGraph(identificationController.deceasedGender);

    // Define the default configuration
    BuchheimWalkerConfiguration config = BuchheimWalkerConfiguration()
      ..siblingSeparation = 70
      ..levelSeparation = 90
      ..subtreeSeparation = 10
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    // Node Widget Builder
    NodeWidgetBuilder builder = (node) {
      String label = node.key?.value as String;
      Color color = impedimentController.getNodeColor(label);
      return circleWidget(label, color);
    };

    // Apply the algorithm
    BuchheimWalkerAlgorithm algorithm =
        BuchheimWalkerAlgorithm(config, TreeEdgeRenderer(config));

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
        padding: EdgeInsets.only(
          left: width * .06,
          right: width * .06,
          bottom: 60,
        ),
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
                boundaryMargin: EdgeInsets.all(255),
                minScale: 0.01,
                maxScale: 2.6,
                child: GraphView(
                  graph: graph,
                  algorithm: algorithm,
                  builder: builder,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationPage(
                        identificationController: identificationController,
                        impedimentController: impedimentController,
                        totalProperty:
                            identificationController.property.getTotal(),
                        propertyAmount:
                            identificationController.property.getAmount(),
                        debtAmount: identificationController.property.getDebt(),
                        testamentAmount:
                            identificationController.property.getTestament(),
                        funeralAmount:
                            identificationController.property.getFuneral(),
                        selectedHeirs: impedimentController.heirQuantity,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleWidget(String label, Color color) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 50,
        minHeight: 50,
        maxWidth: 80,
        maxHeight: 80,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
