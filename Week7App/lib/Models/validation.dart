import '../Models/globalItems.dart';
import '../Models/item.dart';

class Validation {
  static bool isUniqueId(int id) {
    for (Item item in GlobalItems().items) {
      if (item.Id == id) {
        return false; 
      }
    }
    return true;  
  }

  static bool isValidName(String name) {
    return name.isNotEmpty && name.length <= 30; 
  }
  
  static bool isValidDescription(String description) {
    return description.isNotEmpty && description.length <= 50;  
  }
}
