import 'package:radeena/models/enums.dart';
import 'heir_model.dart';
import 'property_model.dart';

class DeceasedModel {
  Gender gender;
  List<HeirModel> selectedHeirs;
  PropertyModel inheritance;

  DeceasedModel({
    required this.gender,
    required this.selectedHeirs,
    required this.inheritance,
  });

  Gender getGender() {
    return gender;
  }

  List<HeirModel> getSelectedHeirs() {
    return selectedHeirs;
  }

  PropertyModel getInheritance() {
    return inheritance;
  }

  void setGender(Gender deceasedGender) {
    gender = deceasedGender;
  }

  void setInheritance(PropertyModel inheritanceAmount) {
    inheritance = inheritanceAmount;
  }
}
