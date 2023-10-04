import 'item.dart';

class GlobalItems {
  static final GlobalItems _item = GlobalItems._instance();

  factory GlobalItems() {
    return _item;
  }

  GlobalItems._instance();

  List<Item> items = [
    Item(1, "Doge Coin", "Saver"),
    Item(2,"Elon Musk", "Spender"),
    Item(3, "Donald Trump", "Frequent"),
    Item(4, "Joe Blow","Occasional"),
    Item(5, "Bobbi Jo", "Saver"),
    Item(6, "Seth Caster", "Saver"),
    Item(7, "Jadie Bug", "Spender"),
    Item(8, "Julia Dream", "Saver"),
    Item(9, "Jena Vieve", "Spender"),
    Item(10, "Arnold Layne", "Occasional"),
  ];
}