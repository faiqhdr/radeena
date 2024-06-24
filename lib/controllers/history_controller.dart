import 'package:radeena/models/calculation_model.dart';

class HistoryController {
  final CalculationModel _model = CalculationModel();

  Future<List<Map<String, dynamic>>> getHistory() async {
    return await _model.getHistory();
  }

  Future<void> deleteHistory(int id) async {
    await _model.deleteHistory(id);
  }
}
