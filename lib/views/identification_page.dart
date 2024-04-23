import 'package:flutter/material.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';
import 'package:radeena/models/enums.dart';
import 'package:radeena/models/property_model.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/views/impediment_page.dart';

class IdentificationPage extends StatefulWidget {
  final IdentificationController controller;
  const IdentificationPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _IdentificationPageState createState() => _IdentificationPageState();
}

class _IdentificationPageState extends State<IdentificationPage> {
  int currentStep = 1;

  final _propertyAmountController = TextEditingController();
  final _debtAmountController = TextEditingController();
  final _bequestAmountController = TextEditingController();
  final _funeralAmountController = TextEditingController();

  String? _propertyError;
  String? _debtError;
  String? _bequestError;
  String? _funeralError;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

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
        title: Text("Determine Heirs", style: titleDetermineHeirsStyle()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: _buildInputStep(currentStep),
      ),
    );
  }

  Widget _buildInputStep(int step) {
    switch (step) {
      case 1:
        return _buildPropertyInputStep();
      case 2:
        // Future implementations for gender input step
        return Container();
      case 3:
        // Future implementations for family input step
        return Container();
      default:
        return Container();
    }
  }

  Widget _buildPropertyInputStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Input the Deceased's Property", style: textUnderTitleStyle()),
        TextFormField(
          controller: _propertyAmountController,
          decoration: InputDecoration(
            labelText: "Property's Amount",
            hintText: "Enter amount",
            errorText: _propertyError,
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: _debtAmountController,
          decoration: InputDecoration(
            labelText: "Debt Amount",
            hintText: "Enter amount",
            errorText: _debtError,
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: _bequestAmountController,
          decoration: InputDecoration(
            labelText: "Bequest Amount",
            hintText: "Enter amount",
            errorText: _bequestError,
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: _funeralAmountController,
          decoration: InputDecoration(
            labelText: "Funeral Amount",
            hintText: "Enter amount",
            errorText: _funeralError,
          ),
          keyboardType: TextInputType.number,
        ),
        GestureDetector(
          onTap: _submitPropertyDetails,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text("Next",
                style: TextStyle(color: Colors.white, fontSize: 16.0)),
          ),
        ),
      ],
    );
  }

  void _submitPropertyDetails() {
    setState(() {
      _propertyError = widget.controller
          .updatePropertyAmount(_propertyAmountController.text);
      _debtError =
          widget.controller.updateDebtAmount(_debtAmountController.text);
      _bequestError =
          widget.controller.updateBequestAmount(_bequestAmountController.text);
      _funeralError =
          widget.controller.updateFuneralAmount(_funeralAmountController.text);
      if (_propertyError == null &&
          _debtError == null &&
          _bequestError == null &&
          _funeralError == null) {
        currentStep = 2; // Proceed to next step if no errors
      }
    });
  }

  @override
  void dispose() {
    _propertyAmountController.dispose();
    _debtAmountController.dispose();
    _bequestAmountController.dispose();
    _funeralAmountController.dispose();
    super.dispose();
  }
}
