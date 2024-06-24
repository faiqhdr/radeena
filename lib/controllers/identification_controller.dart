import 'package:radeena/models/property_model.dart';
import 'package:radeena/models/deceased_model.dart';

class IdentificationController {
  final PropertyModel property = PropertyModel(amount: 0.0, total: 0.0);
  final DeceasedModel deceased = DeceasedModel();

  String? updatePropertyAmount(String input) {
    return _updateAmount(input, property.setAmount);
  }

  String? updateDebtAmount(String input) {
    return _updateAmount(input, property.setDebt);
  }

  String? updateTestamentAmount(String input) {
    return _updateAmount(input, property.setTestament);
  }

  String? updateFuneralAmount(String input) {
    return _updateAmount(input, property.setFuneral);
  }

  String? _updateAmount(String input, Function(double) setAmount) {
    var result = validateAndConvert(input);
    if (result['error'] != null) {
      return result['error'];
    }
    double value = result['value']!;
    if (setAmount == property.setTestament && value > property.amount / 3) {
      return 'Testament amount cannot exceed 1/3 of the property amount.';
    }
    setAmount(value);
    property.calculateTotal();
    return null;
  }

  Map<String, dynamic> validateAndConvert(String input) {
    if (input.isEmpty) {
      return {'error': 'Input cannot be empty'};
    }
    try {
      double value = double.parse(input);
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

  String? validateGender() {
    return deceased.validateGender();
  }

  void updateHeirQuantity(String heir, int quantity) {
    deceased.updateHeirQuantity(heir, quantity);
  }

  String? validateHeirs() {
    return deceased.validateHeirs();
  }
}
