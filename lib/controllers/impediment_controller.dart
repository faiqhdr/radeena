import 'package:radeena/models/enums.dart';

class ImpedimentController {
  List<String> getImpediments({
    required Gender gender,
    required bool hasFather,
    required bool hasMother,
    required bool hasHusband,
    required int numberOfWives,
    required int numberOfSons,
    required int numberOfDaughters,
    required bool hasGrandfather,
    required bool hasGrandmother,
    required int numOfBrothers,
    required int numOfSisters,
    required int numOfGrandsons,
    required int numOfGranddaughters,
  }) {
    List<String> impediments = [];

    if (numberOfSons > 0) {
      impediments.add(
          "The grandson is impeded from receiving his inheritance due to the presence of the deceased's son.");
    }

    if (numberOfSons > 0 || numOfGrandsons > 0 || numberOfDaughters > 0) {
      impediments.add(
          "The granddaughter is impeded from receiving her inheritance because of the presence of the deceased's son, grandson, or daughter.");
    }

    if (hasFather) {
      impediments.add(
          "The grandfather is impeded from receiving his inheritance if there is a presence of the deceased's father.");
    }

    if (hasMother) {
      impediments.add(
          "The grandmother is impeded from receiving her inheritance due to the presence of the deceased's mother.");
    }

    if (hasFather || hasGrandfather || numberOfSons > 0 || numOfGrandsons > 0) {
      impediments.add(
          "The germane brother is impeded from receiving his inheritance because of the presence of the deceased's father, grandfather, son, or grandson.");
    }

    if (hasFather || hasGrandfather || numberOfSons > 0 || numOfGrandsons > 0) {
      impediments.add(
          "The germane sister is impeded from receiving her inheritance if there is a presence of the deceased's father, grandfather, son, or grandson.");
    }

    if (hasFather || hasGrandfather || numberOfSons > 0 || numOfGrandsons > 0) {
      impediments.add(
          "The uterine brother is impeded from receiving his inheritance because of the presence of the deceased's father, grandfather, son, or grandson.");
    }

    if (hasFather ||
        hasGrandfather ||
        numberOfSons > 0 ||
        numOfGrandsons > 0 ||
        numberOfDaughters > 0 ||
        numOfGranddaughters > 0) {
      impediments.add(
          "The uterine sister is impeded from receiving her inheritance due to the presence of the deceased's father, grandfather, son, grandson, daughter, or granddaughter.");
    }

    if (hasFather ||
        hasGrandfather ||
        numberOfSons > 0 ||
        numOfGrandsons > 0 ||
        numOfBrothers > 0 ||
        numOfSisters > 0) {
      impediments.add(
          "The consanguine brother is impeded if there is a presence of the deceased's father, grandfather, son, grandson, germane brother, or germane sister.");
    }

    if (hasFather) {
      impediments.add(
          "The paternal grandfather is impeded if there is a presence of father.");
    }

    if (hasMother) {
      impediments.add(
          "The maternal grandmother is impeded because of the presence of the deceased's mother.");
    }

    return impediments;
  }
}
