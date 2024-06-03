import 'package:radeena/models/calculation_model.dart';

class HistoryController {
  final CalculationModel _model = CalculationModel();

  Future<void> saveCalculation(
    String calculationName,
    double totalProperty,
    double propertyAmount,
    double debtAmount,
    double testamentAmount,
    double funeralAmount,
    Map<String, int> selectedHeirs,
    Map<String, double> distribution,
    String divisionStatus,
    int finalShare,
  ) async {
    await _model.saveCalculation(
      calculationName,
      totalProperty,
      propertyAmount,
      debtAmount,
      testamentAmount,
      funeralAmount,
      selectedHeirs,
      distribution,
      divisionStatus,
      finalShare,
    );
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    return await _model.getHistory();
  }

  Future<void> deleteHistory(int id) async {
    await _model.deleteHistory(id);
  }
}
