import 'package:radeena/models/heir_model.dart';
import 'package:radeena/models/enums.dart';

class IdentificationController {
  double? propertyAmount;
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

  void setPropertyAmount(double value) {
    propertyAmount = value;
  }

  void setFamilyDetails({
    required bool hasFather,
    required bool hasMother,
    required int numberOfWives,
    required bool hasHusband,
    required int numberOfSons,
    required int numberOfDaughters,
  }) {
    this.hasFather = hasFather;
    this.hasMother = hasMother;
    this.numberOfWives = numberOfWives;
    this.hasHusband = hasHusband;
    this.numOfSons = numberOfSons;
    this.numOfDaughters = numberOfDaughters;
  }

  HeirModel prepareHeirModel() {
    String position;
    String status;
    String category;

    // Determine position based on family details
    if (hasFather) {
      position = Position.father.toString().split('.').last;
    } else if (hasMother) {
      position = Position.mother.toString().split('.').last;
    } else if (hasHusband) {
      position = Position.husband.toString().split('.').last;
    } else if (numberOfWives > 0) {
      position = Position.wife.toString().split('.').last;
    } else if (numOfSons > 0) {
      position = Position.son.toString().split('.').last;
    } else if (numOfDaughters > 0) {
      position = Position.daughter.toString().split('.').last;
    } else if (hasGrandfather) {
      position = Position.grandfather.toString().split('.').last;
    } else if (hasGrandmother) {
      position = Position.grandmother.toString().split('.').last;
    } else if (numOfBrothers > 0) {
      position = Position.germaneBrother.toString().split('.').last;
    } else if (numOfSisters > 0) {
      position = Position.germaneSister.toString().split('.').last;
    } else if (numOfGrandsons > 0) {
      position = Position.grandson.toString().split('.').last;
    } else if (numOfGranddaughters > 0) {
      position = Position.granddaughter.toString().split('.').last;
    } else {
      position = "Unknown";
    }

    // Set category and status based on position
    switch (position) {
      case "father":
      case "mother":
      case "husband":
      case "wife":
        category = Category.quranic.toString();
        status = Status.primary.toString();
        break;
      case "daughter":
        category = Category.quranic.toString();
        status = Status.substitute.toString();
        break;
      case "son":
        category = Category.residuary.toString();
        status = Status.residuaryByBlood.toString();
        break;
      case "grandson":
      case "granddaughter":
      case "grandfather":
      case "grandmother":
      case "paternalGrandfather":
      case "paternalGrandmother":
      case "maternalGrandfather":
      case "maternalGrandmother":
        category = Category.residuary.toString();
        status = Status.substitute.toString();
        break;
      case "germaneBrother":
      case "consanguineBrother":
        category = Category.residuary.toString();
        status = Status.residuaryByBlood.toString();
        break;
      case "germaneSister":
      case "uterineBrother":
      case "uterineSister":
      case "consanguineSister":
        category = Category.quranic.toString();
        status = Status.secondary.toString();
        break;
      default:
        category = "Unknown Category";
        status = "Unknown Status";
    }

    return HeirModel(
      heirID: 1, // Set the heir ID as needed
      portion: 0, // Initialize with a default value; you may set this later
      position: position,
      category: category,
      status: status,
    );
  }
}
