class DeceasedModel {
  String? gender;
  Map<String, int> heirs = {};

  String? validateGender() {
    if (gender == null) {
      return 'Please select the deceased\'s gender for determining the heirs.';
    }
    return null;
  }

  void setGender(String gender) {
    this.gender = gender;
  }

  void updateHeirQuantity(String heir, int quantity) {
    heirs[heir] = quantity;
  }
}
