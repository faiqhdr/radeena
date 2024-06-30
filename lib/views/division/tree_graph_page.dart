import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/widgets/common_button.dart';
import 'package:radeena/views/calculation/confirmation_page.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';

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
        .buildGraph(identificationController.deceased.gender);

    BuchheimWalkerConfiguration config = BuchheimWalkerConfiguration()
      ..siblingSeparation = 50
      ..levelSeparation = 50
      ..subtreeSeparation = 20
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    NodeWidgetBuilder builder = (node) {
      String label = node.key?.value as String;
      LinearGradient gradient = impedimentController.getNodeGradient(label);
      return gradientCircleWidget(label, gradient);
    };

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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: width * .06,
              right: width * .06,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "Family Tree Graph",
                    style: textUnderTitleStyle(),
                  ),
                ),
                SizedBox(height: 25),
                buildLegend(),
                SizedBox(height: 15),
                Expanded(
                  child: InteractiveViewer(
                    constrained: false,
                    boundaryMargin: EdgeInsets.all(255),
                    minScale: 0.01,
                    child: GraphView(
                      graph: graph,
                      algorithm: algorithm,
                      builder: builder,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 55,
            left: width * 0.25,
            right: width * 0.25,
            child: CommonButton(
              text: "Next",
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
                      selectedHeirs: impedimentController.deceased.heirs,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildLegendItem("Impeded", Colors.red),
        buildLegendItem("Unselected", Colors.grey),
        buildLegendItem("Entitled", Colors.green),
        buildLegendItem("Deceased", Colors.blue),
      ],
    );
  }

  Widget buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(color: Colors.teal.shade800)),
      ],
    );
  }

  Widget gradientCircleWidget(String label, LinearGradient gradient) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 40,
        minHeight: 40,
        maxWidth: 80,
        maxHeight: 80,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
