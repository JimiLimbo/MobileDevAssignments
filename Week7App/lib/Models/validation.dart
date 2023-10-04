import '../Models/globalItems.dart';
import '../Models/item.dart';

class Validation {
  static bool isUniqueId(int id) {
    for (Item item in GlobalItems().items) {
      if (item.Id == id) {
        return false;  // ID is not unique
      }
    }
    return true;  // ID is unique
  }

  static bool isValidName(String name) {
    return name.isNotEmpty && name.length <= 30; 
  }
  // Check if description is not empty and its length is 50 or less
  static bool isValidDescription(String description) {
    return description.isNotEmpty && description.length <= 50;  
  }
}
