import 'package:radeena/models/enums.dart';

class CalculationController {
  double calculatePortion(double inheritance, Portion portion) {
    switch (portion) {
      case Portion.OneSixth:
        return inheritance / 6;
      case Portion.OneFourth:
        return inheritance / 4;
      case Portion.OneThird:
        return inheritance / 3;
      case Portion.OneHalf:
        return inheritance / 2;
      case Portion.TwoThirds:
        return (inheritance * 2) / 3;
      case Portion.OneEighth:
        return inheritance / 8;
      default:
        return 0.0;
    }
  }
}
