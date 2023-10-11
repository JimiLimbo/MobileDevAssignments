import 'package:flutter/material.dart';

import 'Models/Item.dart';
import 'Models/globalData.dart';
import 'Views/editItem.dart';

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
      home: const MyHomePage(title: 'Week 8 Royalties Assignment'),
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
  Item item = new Item(1, "Doge", "Dogecoin", 1.01);

  void _handleButtonPress() {
    setState(() {
      if (!GlobalItems().items.contains((i) => i.Id == item.Id)) {
        GlobalItems().items.add(item);
      }
      Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditItemPage(item: item)))
          .then((value) => {
                setState(
                  () => item =
                      GlobalItems().items.firstWhere((i) => i.Id == item.Id),
                ),
              });
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
                "Item Information",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "Item Id: ${item.Id}",
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
              Text(
                "Price: \$${item.Price.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20),
              ),
              item.Royalty > 0
                  ? Text(
                      "Item Royalty: \$${item.Royalty.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 20),
                    )
                  : Text("No royalty calcualtion"),
              ElevatedButton(
                onPressed: _handleButtonPress,
                child: Text("Edit Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
