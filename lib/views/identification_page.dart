import 'package:flutter/material.dart';
import 'package:radeena/controllers/identification_controller.dart';
import 'package:radeena/styles/style.dart';
import 'package:radeena/models/enums.dart';
import 'package:radeena/views/impediment_page.dart';

class IdentificationPage extends StatefulWidget {
  final IdentificationController controller;
  const IdentificationPage({Key? key, required this.controller})
      : super(key: key);

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
  int numberOfSons = 0;
  int numberOfDaughters = 0;

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
          "Property of the Deceased",
          style: textUnderTitleStyle(),
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Amount of the Property",
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
        title: Text("Mother"),
        value: hasMother,
        onChanged: (value) {
          setState(() {
            hasMother = value!;
          });
        },
      ),
      CheckboxListTile(
        title: Text("Sons"),
        value: numberOfSons > 0,
        onChanged: (value) {
          setState(() {
            if (value!) {
              numberOfSons = 1;
            } else {
              numberOfSons = 0;
            }
          });
        },
      ),
      if (numberOfSons > 0)
        TextFormField(
          decoration: InputDecoration(
            labelText: "Number of Sons (Max 10)",
            hintText: "Enter number",
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              numberOfSons = int.parse(value);
              numberOfSons = numberOfSons.clamp(0, 10);
            });
          },
        ),
      CheckboxListTile(
        title: Text("Daughters"),
        value: numberOfDaughters > 0,
        onChanged: (value) {
          setState(() {
            if (value!) {
              numberOfDaughters = 1;
            } else {
              numberOfDaughters = 0;
            }
          });
        },
      ),
      if (numberOfDaughters > 0)
        TextFormField(
          decoration: InputDecoration(
            labelText: "Number of Daughters (Max 10)",
            hintText: "Enter number",
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              numberOfDaughters = int.parse(value);
              numberOfDaughters = numberOfDaughters.clamp(0, 10);
            });
          },
        ),
      ElevatedButton(
        onPressed: () {
          // Update controller with family details
          widget.controller.setFamilyDetails(
            hasFather: hasFather,
            hasHusband: hasHusband,
            numberOfWives: numberOfWives,
            hasMother: hasMother,
            numberOfSons: numberOfSons,
            numberOfDaughters: numberOfDaughters,
          );

          // Navigate to next page or perform calculation
          // Replace 'NextPage()' with the next page widget
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImpedimentnPage()),
          );
        },
        child: Text("Next"),
      ),
    ],
  );
}

}
