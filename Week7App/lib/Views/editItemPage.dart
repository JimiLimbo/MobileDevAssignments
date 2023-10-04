import 'package:flutter/material.dart';
import '../Models/globalItems.dart';
import '../Models/item.dart';
import '../Models/validation.dart';  // Import the validation class

class EditItemPage extends StatefulWidget {
  final Item item;
  const EditItemPage({Key? key, required this.item}) : super(key: key);

  @override
  State<EditItemPage> createState() => _EditItemPageState(item);
}

class _EditItemPageState extends State<EditItemPage> {
  _EditItemPageState(item);

  late Item item = widget.item;

  TextEditingController itemNameController = new TextEditingController();
  TextEditingController itemDescriptionController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();  // Create a global key to access FormState

  @override
  void initState() {
    super.initState();

    itemNameController.text = item.Name;
    itemDescriptionController.text = item.Description;
  }

  void _updateItemPressed() {
    if (_formKey.currentState?.validate() ?? false) {  // Trigger validation
      var items = GlobalItems().items;
      Item currentItem =
          GlobalItems().items.firstWhere((index) => index.Id == item.Id);

      if (currentItem.Name != itemNameController.text ||
          currentItem.Description != itemDescriptionController.text) {
        currentItem.Name = itemNameController.text;
        currentItem.Description = itemDescriptionController.text;  
      } 

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Edit Item Page"),
        ),
        body: Center(
          child: Form(
            key: _formKey,  // Provide the global key to the Form widget
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: itemNameController,
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (!Validation.isValidName(value ?? '')) {
                      return 'Please enter a unique name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: itemDescriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                  validator: (value) {
                    if (!Validation.isValidDescription(value ?? '')) {
                      return 'Please enter a valid description';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _updateItemPressed,
                  child: Text("Update Item"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

