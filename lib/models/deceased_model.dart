import 'heir_model.dart';
import 'property_model.dart';

class DeceasedModel {
  final int deceasedID;
  final int heirId;
  final int propertyId;
  final List<HeirModel> selectedHeirs;
  PropertyModel inheritance;

  DeceasedModel({
    required this.deceasedID,
    required this.heirId,
    required this.propertyId,
    required this.selectedHeirs,
    required this.inheritance,
  });
}
