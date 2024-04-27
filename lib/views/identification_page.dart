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
  final _testamentAmountController = TextEditingController();
  final _funeralAmountController = TextEditingController();

  String? _propertyError;
  String? _debtError;
  String? _testamentError;
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
          onPressed: () {
            if (currentStep == 1) {
              Navigator.of(context).pop(); // Go back to main page
            } else {
              setState(() {
                currentStep = 1; // Go back to step 1
              });
            }
          },
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
        return _buildGenderInputStep();
      case 3:
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
        SizedBox(height: 16.0),
        TextFormField(
          controller: _propertyAmountController,
          decoration: InputDecoration(
            labelText: "Property's Amount",
            hintText: "Enter amount",
            errorText: _propertyError,
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: _debtAmountController,
          decoration: InputDecoration(
            labelText: "Debt Amount",
            hintText: "Enter amount",
            errorText: _debtError,
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: _testamentAmountController,
          decoration: InputDecoration(
            labelText: "Testament Amount",
            hintText: "Enter amount",
            errorText: _testamentError,
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: _funeralAmountController,
          decoration: InputDecoration(
            labelText: "Funeral Amount",
            hintText: "Enter amount",
            errorText: _funeralError,
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 26.0),
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
      _testamentError = widget.controller
          .updateTestamentAmount(_testamentAmountController.text);
      _funeralError =
          widget.controller.updateFuneralAmount(_funeralAmountController.text);

      if (_propertyError == null &&
          _debtError == null &&
          _testamentError == null &&
          _funeralError == null &&
          widget.controller.property.total >= 0 &&
          (widget.controller.property.debt +
                  widget.controller.property.testament +
                  widget.controller.property.funeral) >
              widget.controller.property.amount) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(
                'The amount of debt, testament, and funeral arrangements, or the total of the debt, testament, and funeral arrangements, must not exceed the property amount; inheritance cannot be calculated.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Understand'),
              ),
            ],
          ),
        );
      } else if (_propertyError == null &&
          _debtError == null &&
          _testamentError == null &&
          _funeralError == null &&
          widget.controller.property.total >= 0 &&
          widget.controller.property.total == 0) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(
                'The total inheritance is 0; inheritance cannot be calculated.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Understand'),
              ),
            ],
          ),
        );
      } else if (_propertyError == null &&
          _debtError == null &&
          _testamentError == null &&
          _funeralError == null &&
          widget.controller.property.total >= 0) {
        currentStep = 2;
      } else {
        String errorMessage = _propertyError ??
            _debtError ??
            _funeralError ??
            'An error occurred.';

        if (_testamentError != null) {
          errorMessage = _testamentError!;
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Understand'),
              ),
            ],
          ),
        );
      }
    });
  }

  Widget _buildGenderInputStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Deceased's Gender", style: textUnderTitleStyle()),
        SizedBox(height: 12.0),
        Row(
          children: [
            Radio(
              value: Gender.male,
              groupValue: widget.controller.deceasedGender,
              onChanged: (value) {
                setState(() {
                  widget.controller.setDeceasedGender(value);
                });
              },
            ),
            Text("Male"),
            SizedBox(width: 26.0),
            Radio(
              value: Gender.female,
              groupValue: widget.controller.deceasedGender,
              onChanged: (value) {
                setState(() {
                  widget.controller.setDeceasedGender(value);
                });
              },
            ),
            Text("Female"),
            SizedBox(width: 42.0),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.controller
                      .setDeceasedGender(null); // Clear the gender selection
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text("Clear", style: TextStyle(fontSize: 14.0)),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        GestureDetector(
          onTap: _submitGenderDetails,
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

  void _submitGenderDetails() {
    setState(() {
      String? genderError = widget.controller.validateGender();
      if (genderError == null) {
        currentStep = 3;
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(genderError),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Understand'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _propertyAmountController.dispose();
    _debtAmountController.dispose();
    _testamentAmountController.dispose();
    _funeralAmountController.dispose();
    super.dispose();
  }
}
