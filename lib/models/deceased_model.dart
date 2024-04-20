class DeceasedModel {
  double? _amount;
  double? _debt;
  double? _bequest;
  double? _funeral;
  double? _totalProperty;

  double? get amount => _amount;
  double? get debt => _debt;
  double? get bequest => _bequest;
  double? get funeral => _funeral;
  double? get totalProperty => _totalProperty;

  set hasMother(bool hasMother) {}

  set amount(double? value) {
    _amount = value;
    _calculateTotalProperty();
  }

  set debt(double? value) {
    _debt = value;
    _calculateTotalProperty();
  }

  set bequest(double? value) {
    _bequest = value;
    _calculateTotalProperty();
  }

  set funeral(double? value) {
    _funeral = value;
    _calculateTotalProperty();
  }

  void setPropertyDetails({
    required double amount,
    required double debt,
    required double bequest,
    required double funeral,
  }) {
    _amount = amount;
    _debt = debt;
    _bequest = bequest;
    _funeral = funeral;
    _calculateTotalProperty();
  }

  void _calculateTotalProperty() {
    if (_amount != null &&
        _debt != null &&
        _bequest != null &&
        _funeral != null) {
      _totalProperty = _amount! - _debt! - _bequest! - _funeral!;
    }
  }

  bool _hasFather = false;
  bool _hasMother = false;
  int _numberOfWives = 0;
  bool _hasHusband = false;
  int _numberOfSons = 0;
  int _numberOfDaughters = 0;

  bool get hasFather => _hasFather;
  bool get hasMother => _hasMother;
  int get numberOfWives => _numberOfWives;
  bool get hasHusband => _hasHusband;
  int get numberOfSons => _numberOfSons;
  int get numberOfDaughters => _numberOfDaughters;

  set hasFather(bool value) {
    _hasFather = value;
  }

  set numberOfWives(int value) {
    _numberOfWives = value;
  }

  set hasHusband(bool value) {
    _hasHusband = value;
  }

  set numberOfSons(int value) {
    _numberOfSons = value;
  }

  set numberOfDaughters(int value) {
    _numberOfDaughters = value;
  }
}
