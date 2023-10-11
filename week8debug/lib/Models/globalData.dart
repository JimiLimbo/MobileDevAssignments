import 'Item.dart';

class GlobalItems {
  static final GlobalItems _item = GlobalItems._instance(); //definition

  factory GlobalItems() {
    return _item;
  }
  GlobalItems._instance(); //definition of private constructor

  List<Item> items = [];
}
