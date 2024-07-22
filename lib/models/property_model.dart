//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

class PropertyModel {
  double amount;
  double debt;
  double testament;
  double funeral;
  double total;

  PropertyModel({
    required this.amount,
    this.debt = 0,
    this.testament = 0,
    this.funeral = 0,
    required this.total,
  });

  // Accessor
  double getAmount() => amount;
  double getDebt() => debt;
  double getTestament() => testament;
  double getFuneral() => funeral;
  double getTotal() => total;

  // Mutator
  void setAmount(double propertyAmount) { amount = propertyAmount; }
  void setDebt(double debtAmount) { debt = debtAmount; }
  void setTestament(double testamentAmount) { testament = testamentAmount; }
  void setFuneral(double funeralAmount) { funeral = funeralAmount; }
  void setTotal(double totalAmount) { total = totalAmount; }

  // Calculate Total Property Value After Deductions
  void calculateTotal() {
    double total = amount - debt - testament - funeral;
    setTotal(total < 0 ? 0 : total);
  }
}
