import 'package:flutter/material.dart';
import 'package:radeena/models/deceased_model.dart';
import 'package:radeena/views/identification_page.dart';

class IdentificationController {
  DeceasedModel _deceasedModel = DeceasedModel();

  void handleNextButton({
    required double amount,
    required double debt,
    required double bequest,
    required double funeral,
    required BuildContext context,
  }) {
    // Calculate total property value
    double totalProperty = amount - debt - bequest - funeral;

    // Update deceased model with property details
    _deceasedModel.setPropertyDetails(
      amount: amount,
      debt: debt,
      bequest: bequest,
      funeral: funeral,
    );

    // Navigate to next page (e.g., selecting deceased's gender)
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => IdentificationPage(controller: this)),
    );
  }

  void setPropertyAmount(double amount) {
    _deceasedModel.amount = amount;
  }

  void setFamilyDetails({
    required bool hasFather,
    required bool hasMother,
    required int numberOfWives,
    required bool hasHusband,
    required int numberOfSons,
    required int numberOfDaughters,
  }) {
    _deceasedModel.hasFather = hasFather;
    _deceasedModel.hasMother = hasMother;
    _deceasedModel.numberOfWives = numberOfWives;
    _deceasedModel.hasHusband = hasHusband;
    _deceasedModel.numberOfSons = numberOfSons;
    _deceasedModel.numberOfDaughters = numberOfDaughters;
  }

  void dispose() {
    // Clean up resources if needed
  }
}
