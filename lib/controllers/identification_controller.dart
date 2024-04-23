import 'package:radeena/models/heir_model.dart';
import 'package:radeena/models/deceased_model.dart';
import 'package:radeena/models/property_model.dart';

class IdentificationController {
  PropertyModel _property =
      PropertyModel(propertyID: 1, amount: 0.0, total: 0.0);

  PropertyModel get property => _property;

  // Update methods with validation and exception handling
  String? updatePropertyAmount(String input) {
    return _updateAmount(input, _property.setAmount);
  }

  String? updateDebtAmount(String input) {
    return _updateAmount(input, _property.setDebt);
  }

  String? updateBequestAmount(String input) {
    return _updateAmount(input, _property.setBequest);
  }

  String? updateFuneralAmount(String input) {
    return _updateAmount(input, _property.setFuneral);
  }

  // Helper method to update amounts
  String? _updateAmount(String input, Function(double) setAmount) {
    var result = validateAndConvert(input);
    if (result['error'] != null) {
      return result['error'];
    }
    setAmount(result['value']!);
    calculateTotal();
    return null;
  }

  // Calculate the total value
  void calculateTotal() {
    double total = _property.amount -
        _property.debt -
        _property.bequest -
        _property.funeral;
    _property.setTotal(total);
  }

  // Validate the input and convert to a double
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
      // Handle parsing error
      return {'error': 'Invalid input format'};
    }
  }
}
