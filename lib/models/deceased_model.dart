//  Created by Muhammad Faiq Haidar on 22/07/2024.
//  Copyright © 2024 Muhammad Faiq Haidar. All rights reserved.

class DeceasedModel {
  String? gender;
  Map<String, int> heirs = {}; // Store Heirs and Quantities

  // Validate If Gender is Set
  String? validateGender() {
    if (gender == null) {
      return 'Please select the deceased\'s gender for determining the heirs.';
    }
    return null;
  }

  // Set Deceased's Gender
  void setGender(String gender) {
    this.gender = gender;
  }

  // Update Specific Heir Quantities
  void updateHeirQuantity(String heir, int quantity) {
    heirs[heir] = quantity;
  }
}
