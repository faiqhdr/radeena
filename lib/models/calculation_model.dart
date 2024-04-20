class CalculationModel {
  final int calculationID;
  final int deceasedId;
  double initialShare;
  double finalShare;
  String divisionStatus;
  double dividedInheritance;

  CalculationModel({
    required this.calculationID,
    required this.deceasedId,
    required this.initialShare,
    required this.finalShare,
    required this.divisionStatus,
    required this.dividedInheritance,
  });
}