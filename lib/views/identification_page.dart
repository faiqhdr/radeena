import 'package:flutter/material.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/controllers/impediment_controller.dart';
import 'package:radeena/models/enums.dart';
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
  Gender? selectedGender;
  bool hasFather = false;
  bool hasMother = false;
  int numberOfWives = 0;
  bool hasHusband = false;
  int numOfSons = 0;
  int numOfDaughters = 0;
  bool hasGrandfather = false;
  bool hasGrandmother = false;
  int numOfBrothers = 0;
  int numOfSisters = 0;
  int numOfGrandsons = 0;
  int numOfGranddaughters = 0;

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
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Determine Heirs",
          style: titleDetermineHeirsStyle(),
        ),
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
        return _buildFamilyInputStep();
      default:
        return Container();
    }
  }

  Widget _buildPropertyInputStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Input the Deceased's Property",
          style: textUnderTitleStyle(),
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Property's Amount",
            hintText: "Enter amount",
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            widget.controller.setPropertyAmount(double.parse(value));
          },
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              currentStep = 2;
            });
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderInputStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Deceased's Gender",
          style: textUnderTitleStyle(),
        ),
        ListTile(
          title: Text("Male"),
          leading: Radio<Gender>(
            value: Gender.male,
            groupValue: selectedGender,
            onChanged: (Gender? value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text("Female"),
          leading: Radio<Gender>(
            value: Gender.female,
            groupValue: selectedGender,
            onChanged: (Gender? value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              currentStep = 3;
            });
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFamilyInputStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Deceased's Family",
          style: textUnderTitleStyle(),
        ),
        CheckboxListTile(
          title: Text("Father"),
          value: hasFather,
          onChanged: (value) {
            setState(() {
              hasFather = value!;
            });
          },
        ),
        CheckboxListTile(
          title: Text("Mother"),
          value: hasMother,
          onChanged: (value) {
            setState(() {
              hasMother = value!;
            });
          },
        ),
        if (selectedGender == Gender.female)
          CheckboxListTile(
            title: Text("Husband"),
            value: hasHusband,
            onChanged: (value) {
              setState(() {
                hasHusband = value!;
              });
            },
          ),
        if (!hasHusband && selectedGender == Gender.male)
          CheckboxListTile(
            title: Text("Wife"),
            value: numberOfWives > 0,
            onChanged: (value) {
              setState(() {
                if (value!) {
                  numberOfWives = 1;
                } else {
                  numberOfWives = 0;
                }
              });
            },
          ),
        if (numberOfWives > 0)
          TextFormField(
            decoration: InputDecoration(
              labelText: "Number of Wives (Max 4)",
              hintText: "Enter number",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                numberOfWives = int.parse(value);
                numberOfWives = numberOfWives.clamp(0, 4);
              });
            },
          ),
        CheckboxListTile(
          title: Text("Sons"),
          value: numOfSons > 0,
          onChanged: (value) {
            setState(() {
              if (value!) {
                numOfSons = 1;
              } else {
                numOfSons = 0;
              }
            });
          },
        ),
        if (numOfSons > 0)
          TextFormField(
            decoration: InputDecoration(
              labelText: "Number of Sons (Max 10)",
              hintText: "Enter number",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                numOfSons = int.parse(value);
                numOfSons = numOfSons.clamp(0, 10);
              });
            },
          ),
        CheckboxListTile(
          title: Text("Daughters"),
          value: numOfDaughters > 0,
          onChanged: (value) {
            setState(() {
              if (value!) {
                numOfDaughters = 1;
              } else {
                numOfDaughters = 0;
              }
            });
          },
        ),
        if (numOfDaughters > 0)
          TextFormField(
            decoration: InputDecoration(
              labelText: "Number of Daughters (Max 10)",
              hintText: "Enter number",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                numOfDaughters = int.parse(value);
                numOfDaughters = numOfDaughters.clamp(0, 10);
              });
            },
          ),
        CheckboxListTile(
          title: Text("Grandfather"),
          value: hasGrandfather,
          onChanged: (value) {
            setState(() {
              hasGrandfather = value!;
            });
          },
        ),
        CheckboxListTile(
          title: Text("Grandmother"),
          value: hasGrandmother,
          onChanged: (value) {
            setState(() {
              hasGrandmother = value!;
            });
          },
        ),
        CheckboxListTile(
          title: Text("Brother"),
          value: numOfBrothers > 0,
          onChanged: (value) {
            setState(() {
              if (value!) {
                numOfBrothers = 1;
              } else {
                numOfBrothers = 0;
              }
            });
          },
        ),
        if (numOfBrothers > 0)
          TextFormField(
            decoration: InputDecoration(
              labelText: "Number of Brothers (Max 10)",
              hintText: "Enter number",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                numOfBrothers = int.parse(value);
                numOfBrothers = numOfBrothers.clamp(0, 10);
              });
            },
          ),
        CheckboxListTile(
          title: Text("Sister"),
          value: numOfSisters > 0,
          onChanged: (value) {
            setState(() {
              if (value!) {
                numOfSisters = 1;
              } else {
                numOfSisters = 0;
              }
            });
          },
        ),
        if (numOfSisters > 0)
          TextFormField(
            decoration: InputDecoration(
              labelText: "Number of Sisters (Max 10)",
              hintText: "Enter number",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                numOfSisters = int.parse(value);
                numOfSisters = numOfSisters.clamp(0, 10);
              });
            },
          ),
        CheckboxListTile(
          title: Text("Grandson"),
          value: numOfGrandsons > 0,
          onChanged: (value) {
            setState(() {
              if (value!) {
                numOfGrandsons = 1;
              } else {
                numOfGrandsons = 0;
              }
            });
          },
        ),
        if (numOfGrandsons > 0)
          TextFormField(
            decoration: InputDecoration(
              labelText: "Number of Grandsons (Max 10)",
              hintText: "Enter number",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                numOfGrandsons = int.parse(value);
                numOfGrandsons = numOfGrandsons.clamp(0, 10);
              });
            },
          ),
        CheckboxListTile(
          title: Text("Granddaughter"),
          value: numOfGranddaughters > 0,
          onChanged: (value) {
            setState(() {
              if (value!) {
                numOfGranddaughters = 1;
              } else {
                numOfGranddaughters = 0;
              }
            });
          },
        ),
        if (numOfGranddaughters > 0)
          TextFormField(
            decoration: InputDecoration(
              labelText: "Number of Granddaughters (Max 10)",
              hintText: "Enter number",
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                numOfGranddaughters = int.parse(value);
                numOfGranddaughters = numOfGranddaughters.clamp(0, 10);
              });
            },
          ),
        ElevatedButton(
          onPressed: () {
            widget.controller.setFamilyDetails(
              hasFather: hasFather,
              hasHusband: hasHusband,
              numberOfWives: numberOfWives,
              hasMother: hasMother,
              numberOfSons: numOfSons,
              numberOfDaughters: numOfDaughters,
            );

            var heirModel = widget.controller.prepareHeirModel();

            var impedimentController = ImpedimentController();
            var impediments = impedimentController.getImpediments(
              gender: selectedGender!,
              hasFather: hasFather,
              hasMother: hasMother,
              hasHusband: hasHusband,
              numberOfWives: numberOfWives,
              numberOfSons: numOfSons,
              numberOfDaughters: numOfDaughters,
              hasGrandfather: hasGrandfather,
              hasGrandmother: hasGrandmother,
              numOfBrothers: numOfBrothers,
              numOfSisters: numOfSisters,
              numOfGrandsons: numOfGrandsons,
              numOfGranddaughters: numOfGranddaughters,
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImpedimentPage(
                  impediments: impediments,
                ),
              ),
            );
          },
          child: Text("Next"),
        ),
      ],
    );
  }
}
