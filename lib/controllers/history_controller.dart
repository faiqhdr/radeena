//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

import 'package:radeena/models/calculation_model.dart';

class HistoryController {
  // Instance of CalculationModel
  final CalculationModel _model = CalculationModel();

  // Retrieve Record
  Future<List<Map<String, dynamic>>> getHistory() async {
    return await _model.getHistory();
  }

  // Delete Record by ID
  Future<void> deleteHistory(int id) async {
    await _model.deleteHistory(id);
  }
}
