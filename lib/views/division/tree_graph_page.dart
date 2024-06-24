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
      ..siblingSeparation = 60
      ..levelSeparation = 60
      ..subtreeSeparation = 60
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
