import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:horizontal_list/horizontal_list.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal list Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Horizontal list Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _itemsComponent() {
    List<Widget> myList = [];
    for (var i = 0; i < 10; i++) {
      myList.add(Card(
          child: Container(
              width: 300,
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
              child: Center(
                  child: Text('Card ${i + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold))))));
    }
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            const SizedBox(height: 150),
            HorizontalListView(
              width: double.maxFinite,
              height: 200,
              list: _itemsComponent(),
              iconPrevious: const Icon(Icons.arrow_back_ios),
              iconNext: const Icon(Icons.arrow_forward_ios),
              onPreviousPressed: () {
                //DO WHAT YOU WANT ON PREVIOUS PRESSED
                log('onPreviousPressed');
              },
              onNextPressed: () {
                //DO WHAT YOU WANT ON NEXT PRESSED
                log('onNextPressed');
              },
            ),
          ],
        ));
  }
}
