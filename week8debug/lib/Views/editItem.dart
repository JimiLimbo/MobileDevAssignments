import 'package:flutter/material.dart';
import 'package:week8debug/BusinessLogic/TaxCalculation.dart';
//import 'package:week_6/BusinessLogic/TaxCalculation.dart';
import '../Models/Item.dart';
import '../Models/globalData.dart';

class EditItemPage extends StatefulWidget {
  final Item item; //create new public property

  const EditItemPage({Key? key, required this.item})
      : super(key: key); //add param to constructor

  @override
  State<EditItemPage> createState() =>
      _EditItemPageState(item); //add property to private state method
}

class _EditItemPageState extends State<EditItemPage> {
  _EditItemPageState(
      item); //invoke private state method with variable defined in first class ^^^^

  late Item item = widget
      .item; //use keyword late to signal to compiler that variable will be initialized later in code

  TextEditingController itemNameController = new TextEditingController();
  TextEditingController itemDescriptionController = new TextEditingController();
  TextEditingController itemPriceController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemNameController.text = item.Name;
    itemDescriptionController.text = item.Description;
    itemPriceController.text = item.Price.toStringAsFixed(2);
  }

  void _updateItemPressed() {
    Item currentItem = GlobalItems().items.firstWhere((i) => i.Id == item.Id);
    currentItem.Name = itemNameController.text;
    currentItem.Description = itemDescriptionController.text;
    currentItem.Price = double.tryParse(itemPriceController.text) ?? 0;
    TaxCalculation taxCalculation = new TaxCalculation();
    print("Before calculation, Royalty: ${currentItem.Royalty}, Price: ${currentItem.Price}");
    currentItem.Royalty = taxCalculation.CalculateItemRoyalty(currentItem);
    print("After calculation, Royalty: ${currentItem.Royalty}");


    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text(
              "Edit Item Page",
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: itemNameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: itemDescriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                TextField(
                  controller: itemPriceController,
                  decoration: InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: _updateItemPressed,
                  child: Text("Update Item"),
                ),
              ],
            ),
          )),
    );
  }
}
