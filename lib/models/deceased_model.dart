import 'package:radeena/models/enums.dart';
import 'heir_model.dart';
import 'property_model.dart';

class DeceasedModel {
  final int deceasedID;
  Gender gender;
  List<HeirModel> selectedHeirs;
  PropertyModel inheritance;

  DeceasedModel({
    required this.deceasedID,
    required this.gender,
    required this.selectedHeirs,
    required this.inheritance,
  });

  int getDeceasedID() {
    return deceasedID;
  }

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
