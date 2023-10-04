import 'package:flutter/material.dart';

import 'Models/globalItems.dart';
import 'Models/item.dart';
import 'Views/editItemPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  Item item = new Item(1, "Shiba", "ShibaInu");

  void _handleButtonPress() {
    setState(() {
      if (!GlobalItems().items.contains(item)) {
        GlobalItems().items.add(item);
      }
      Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditItemPage(item: item)))
          .then(((value) => {
                setState(() => item = GlobalItems()
                    .items
                    .firstWhere((index) => index.Id == item.Id))
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Item ID: ${item.Id}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Item Name: ${item.Name}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Item Description: ${item.Description}",
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: _handleButtonPress,
                child: Text("Edit Item"),
              ),
              Divider(color:Colors.deepPurple,)
            ],
          ),
        ),
      ),
    );
  }
}
