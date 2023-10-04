import 'package:flutter/material.dart';
import 'Models/globalItems.dart';
import 'Models/item.dart';
import 'Views/editItemPage.dart';
import 'Models/validation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caster List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Caster Week 7'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _sortItems() {// Sort items by Id in ascending order 
    GlobalItems().items.sort((a, b) => a.Id.compareTo(b.Id));  
  }
   
  void _handleDeleteItem(Item item) {
    setState(() {
      GlobalItems().items.remove(item);
      _sortItems();
    });
  }

  void _handleButtonPress(Item item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemPage(item: item),
      ),
    ).then((value) {
      setState(
          () {}); 
    });
  }

  List<Widget> _buildItemWidgets() {
  return GlobalItems().items.expand((item) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            Text('ID: ${item.Id}', style: TextStyle(fontSize: 20)),
            Text('Name: ${item.Name}', style: TextStyle(fontSize: 20)),
            Text('Description: ${item.Description}', style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _showAddItemDialog,  // Open the Add Item dialog
                  child: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,  
                  ),
                ),
                ElevatedButton(  
                  onPressed: () => _handleButtonPress(item),
                  child: Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, 
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showDeleteConfirmationDialog(item),
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,  
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Divider(color: Colors.deepPurple),
    ];
  }).toList();
}


  

  Future<void> _showAddItemDialog() async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int id = 0;
  String name = '';
  String description = '';

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Item'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final int? idValue = int.tryParse(value ?? '0');
                  if (idValue == null || !Validation.isUniqueId(idValue)) {
                    return 'Please enter a unique ID';
                  }
                  id = idValue!;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || !Validation.isValidName(value)) {
                    return 'Please enter a valid name';
                  }
                  name = value;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || !Validation.isValidDescription(value)) {
                    return 'Please enter a valid description';
                  }
                  description = value;
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Add'),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                final newItem = Item(id, name, description);
                setState(() {
                  GlobalItems().items.add(newItem);
                  _sortItems();  // Sort the items after addition
                });
                Navigator.of(context).pop();  // Close the dialog
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showDeleteConfirmationDialog(Item item) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('ID: ${item.Id}'),
              Text('Name: ${item.Name}'),
              Text('Description: ${item.Description}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();  
              },
            ),
            TextButton(
              child: Text('Proceed'),
              onPressed: () {
                _handleDeleteItem(item); 
                Navigator.of(context).pop();  
              },
            ),
          ],
        );
      },
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _buildItemWidgets(),
        ),
      ),
    );
  }
}


