import 'package:flutter/material.dart';
import 'package:radeena/styles/style.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:radeena/models/enums.dart';
import 'package:radeena/views/distribution/impediment_page.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';

class IdentificationPage extends StatefulWidget {
  final IdentificationController controller;
  final ImpedimentController impedimentController;

  const IdentificationPage({
    Key? key,
    required this.controller,
    required this.impedimentController,
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
              Navigator.of(context).pop();
            } else {
              setState(() {
                currentStep = 1;
              });
            }
          },
        ),
        title: Text("Determine Heirs", style: titleDetermineHeirsStyle()),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: _buildInputStep(currentStep),
          ),
          Positioned(
            right: 40,
            top: 640,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade300, Colors.teal.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(17),
              ),
              child: FloatingActionButton(
                onPressed: () {
                  if (currentStep == 1) {
                    _submitPropertyDetails();
                  } else if (currentStep == 2) {
                    _submitGenderDetails();
                  } else if (currentStep == 3) {
                    _navigateToImpedimentPage();
                  }
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
        return _buildFamilyInputStep();
      default:
        return Container();
    }
  }

  Widget _buildPropertyInputStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Input the Deceased's Property", style: textUnderTitleStyle()),
        SizedBox(height: 25.0),
        _buildTextInputField(
          controller: _propertyAmountController,
          label: "Property's Amount",
          hint: "Enter amount",
          errorText: _propertyError,
        ),
        _buildTextInputField(
          controller: _debtAmountController,
          label: "Debt Amount",
          hint: "Enter amount",
          errorText: _debtError,
        ),
        _buildTextInputField(
          controller: _testamentAmountController,
          label: "Testament Amount",
          hint: "Enter amount",
          errorText: _testamentError,
        ),
        _buildTextInputField(
          controller: _funeralAmountController,
          label: "Funeral Amount",
          hint: "Enter amount",
          errorText: _funeralError,
        ),
        SizedBox(height: 420),
      ],
    );
  }

  Widget _buildTextInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            errorText: errorText,
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.0),
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
        SizedBox(height: 25.0),
        Row(
          children: [
            Radio(
              value: Gender.male,
              groupValue: widget.controller.deceasedGender,
              onChanged: (Gender? value) {
                setState(() {
                  widget.controller.setDeceasedGender(value);
                  widget.impedimentController.setDeceasedGender(value);
                });
              },
            ),
            Text("Male"),
            SizedBox(width: 25.0),
            Radio(
              value: Gender.female,
              groupValue: widget.controller.deceasedGender,
              onChanged: (Gender? value) {
                setState(() {
                  widget.controller.setDeceasedGender(value);
                  widget.impedimentController.setDeceasedGender(value);
                });
              },
            ),
            Text("Female"),
            SizedBox(width: 42.0),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.controller.setDeceasedGender(null);
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
        SizedBox(height: 600),
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

  Widget _buildFamilyInputStep() {
    Gender? gender = widget.controller.deceasedGender;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildFamilyMemberInputs(gender),
          SizedBox(height: 600),
        ],
      ),
    );
  }

  List<Widget> _buildFamilyMemberInputs(Gender? gender) {
    var inputs = <Widget>[];
    List<Map<String, dynamic>> familyMembers = [
      {'title': "Father", 'max': 1},
      {'title': "Mother", 'max': 4},
      {'title': "Paternal Grandfather", 'max': 1},
      {'title': "Paternal Grandmother", 'max': 1},
      {'title': "Maternal Grandmother", 'max': 1},
      {
        'title': gender == Gender.male ? "Wife" : "Husband",
        'max': gender == Gender.male ? 4 : 1
      },
      {'title': "Son", 'max': 10},
      {'title': "Daughter", 'max': 10},
      {'title': "Grandson", 'max': 10},
      {'title': "Granddaughter", 'max': 10},
      {'title': "Brother", 'max': 8},
      {'title': "Sister", 'max': 8},
      {'title': "Paternal Half-Brother", 'max': 8},
      {'title': "Paternal Half-Sister", 'max': 8},
      {'title': "Maternal Half-Brother", 'max': 8},
      {'title': "Maternal Half-Sister", 'max': 8},
      {'title': "Son of Brother", 'max': 10},
      {'title': "Son of Paternal Half-Brother", 'max': 10},
      {'title': "Uncle", 'max': 5},
      {'title': "Paternal Uncle", 'max': 5},
      {'title': "Son of Uncle", 'max': 10},
      {'title': "Son of Paternal Uncle", 'max': 10},
    ];

    int midpoint = (familyMembers.length / 2).ceil();

    for (var i = 0; i < midpoint; i++) {
      var member = familyMembers[i];
      var nextMemberIndex = i + midpoint;

      inputs.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildFamilyMemberInput(
                member['title'] as String,
                max: member['max'] as int,
              ),
            ),
            SizedBox(width: 16),
            if (nextMemberIndex < familyMembers.length)
              Expanded(
                child: _buildFamilyMemberInput(
                  familyMembers[nextMemberIndex]['title'] as String,
                  max: familyMembers[nextMemberIndex]['max'] as int,
                ),
              ),
          ],
        ),
      );
    }

    inputs.add(SizedBox(height: 0));
    return inputs;
  }

  void _navigateToImpedimentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImpedimentPage(
          identificationController: widget.controller,
          impedimentController: widget.impedimentController,
          impediments: widget.impedimentController.getImpediments(),
        ),
      ),
    );
  }

  Widget _buildFamilyMemberInput(String title, {required int max}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        InputQty(
          initVal: 0,
          minVal: 0,
          maxVal: max,
          steps: 1,
          qtyFormProps: QtyFormProps(enableTyping: true),
          decoration: QtyDecorationProps(
            isBordered: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            minusBtn: Icon(Icons.remove, color: Colors.red),
            plusBtn: Icon(Icons.add, color: Colors.green),
          ),
          onQtyChanged: (val) {
            int quantity = val is double ? val.toInt() : val;
            widget.impedimentController.updateHeirQuantity(title, quantity);
          },
        ),
        SizedBox(height: 16),
      ],
    );
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
