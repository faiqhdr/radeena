import 'enums.dart';
import 'deceased_model.dart';

class CalculationModel {
  final int calculationID;
  double initialShare;
  double finalShare;
  DivisionStatus divisionStatus;
  double dividedInheritance;
  DeceasedModel deceasedDetails;

  CalculationModel({
    required this.calculationID,
    required this.initialShare,
    required this.finalShare,
    required this.divisionStatus,
    required this.dividedInheritance,
    required this.deceasedDetails,
  });

  int getCalculationID() {
    return calculationID;
  }

  double getInitialShare() {
    return initialShare;
  }

  double getFinalShare() {
    return finalShare;
  }

  DivisionStatus getDivisionStatus() {
    return divisionStatus;
  }

  double getDividedInheritance() {
    return dividedInheritance;
  }

  DeceasedModel getDeceasedDetails() {
    return deceasedDetails;
  }

  void setInitialShare(double initialShareLCM) {
    initialShare = initialShareLCM;
  }

  void setFinalShare(double finalShareLCM) {
    finalShare = finalShareLCM;
  }

  void setDivisionStatus(DivisionStatus aulRaddStatus) {
    divisionStatus = aulRaddStatus;
  }

  void setDividedInheritance(double dividedHeirInheritance) {
    dividedInheritance = dividedHeirInheritance;
  }

  void setDeceasedDetails(DeceasedModel deceasedDetailList) {
    deceasedDetails = deceasedDetailList;
  }
}
