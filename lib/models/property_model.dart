class PropertyModel {
  final int propertyID;
  double amount;
  double debt;
  double bequest;
  double funeral;
  double total;

  PropertyModel({
    required this.propertyID,
    required this.amount,
    this.debt = 0,
    this.bequest = 0,
    this.funeral = 0,
    required this.total,
  });

  int getPropertyID() {
    return propertyID;
  }

  double getAmount() {
    return amount;
  }

  double getDebt() {
    return debt;
  }

  double getBequest() {
    return bequest;
  }

  double getFuneral() {
    return funeral;
  }

  double getTotal() {
    return total;
  }

  void setAmount(double propertyAmount) {
    amount = propertyAmount;
  }

  void setDebt(double debtAmount) {
    debt = debtAmount;
  }

  void setBequest(double bequestAmount) {
    bequest = bequestAmount;
  }

  void setFuneral(double funeralAmount) {
    funeral = funeralAmount;
  }

  void setTotal(double totalAmount) {
    total = totalAmount;
  }
}
