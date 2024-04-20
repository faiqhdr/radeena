class PropertyModel {
  final int propertyID;
  final double amount;
  final double? debt;
  final double? bequest;
  final double? funeral;
  double total;

  PropertyModel({
    required this.propertyID,
    required this.amount,
    this.debt = 0,
    this.bequest = 0,
    this.funeral = 0,
    required this.total,
  });
}
