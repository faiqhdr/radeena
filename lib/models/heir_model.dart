import 'enums.dart';

class HeirModel {
  Portion portion;
  Position position;
  Category category;
  Status status;

  HeirModel({
    required this.portion,
    required this.position,
    required this.category,
    required this.status,
  });

  Portion getPortion() { return portion; }
  Position getPosition() { return position; }
  Category getCategory() { return category; }
  Status getStatus() { return status; }

  void setPortion(Portion heirPortion) { portion = heirPortion; }
  void setPosition(Position heirPosition) { position = heirPosition; }
  void setCategory(Category heirCategory) { category = heirCategory; }
  void setStatus(Status heirStatus) { status = heirStatus; }
}
