//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

import 'package:radeena/models/property_model.dart';
import 'package:radeena/models/deceased_model.dart';

class IdentificationController {
  // Instances
  final PropertyModel property = PropertyModel(amount: 0.0, total: 0.0);
  final DeceasedModel deceased = DeceasedModel();

  // Update Property Amount with Validation
  String? updatePropertyAmount(String input) {
    return _updateAmount(input, property.setAmount);
  }

  // Update Debt Amount with Validation
  String? updateDebtAmount(String input) {
    return _updateAmount(input, property.setDebt);
  }

  // Update Testament Amount with Validation
  String? updateTestamentAmount(String input) {
    return _updateAmount(input, property.setTestament);
  }

  // Update Funeral Amount with Validation
  String? updateFuneralAmount(String input) {
    return _updateAmount(input, property.setFuneral);
  }

  // Helper Method to Validate and Update Amounts
  String? _updateAmount(String input, Function(double) setAmount) {
    var result = validateAndConvert(input);
    if (result['error'] != null) {
      return result['error'];
    }
    double value = result['value']!;
    // Error for Testament Input
    if (setAmount == property.setTestament && value > property.amount / 3) {
      return 'Testament amount cannot exceed 1/3 of the property amount.';
    }
    setAmount(value);
    property.calculateTotal();
    return null;
  }

  // Validate and Convert Input string to double
  Map<String, dynamic> validateAndConvert(String input) {
    // Error for Empty Input
    if (input.isEmpty) {
      return {'error': 'Input cannot be empty'};
    }
    try {
      double value = double.parse(input);
      // Error for Negative Value
      if (value < 0) {
        return {'error': 'Value cannot be negative'};
      }
      return {'value': value};
    } catch (e) {
      return {'error': 'Invalid input format'};
    }
  }

  void setDeceasedGender(String gender) {
    deceased.setGender(gender);
  }

  // Validate Gender
  String? validateGender() {
    return deceased.validateGender();
  }
}
