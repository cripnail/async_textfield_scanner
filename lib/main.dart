import 'fetch_file.dart';
import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';
import 'dart:async';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _searchText = "";
  List _list = ['data.txt', 'assets/text1.txt', '/assets/text2.txt'];
  TextEditingController _searchController;
  final label = "Искомый файл";
  // final List dummyList = ['/assets/data.txt', 'assets/text1.txt', '/assets/text2.txt'];
  // List<String> newDummyList = List.from(dummyList);
  //
  // onItemChanged(String value) {
  //   setState(() {
  //     newDummyList = dummyList
  //         .where((string) => string.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  // create a Future that returns List
  Future<List> fetchFileFromAssets(String assetsPath) async {
    await Future.delayed(Duration(milliseconds: 5000));
    List _list = new List();
    String _inputText = _searchController.text;
    // Now we create a list from the text input of three items
    // to mock a list of items from an http call
    _list.add(_inputText + ' /assets/data.txt');
    _list.add(_inputText + ' assets/text1.txt');
    _list.add(_inputText + ' /assets/text2.txt');
    return _list;
  }

  Future<List> fetchData() async {
    await Future.delayed(Duration(milliseconds: 3000));
    List _list = new List();
    String _inputText = _searchController.text;
    List _jsonList = [
      {
        'label': _inputText + ' data.txt',
        'value': '/assets/data.txt'
      },
      {
        'label': _inputText + ' text1.txt',
        'value': '/assets/text1.txt'
      },
      {
        'label': _inputText + ' text2.txt',
        'value': 'assets/text2.txt',
      },
    ];
    // create a list of 3 objects from a fake json response
    _list.add(new TestItem.fromJson(_jsonList[0]));
    _list.add(new TestItem.fromJson(_jsonList[1]));
    _list.add(new TestItem.fromJson(_jsonList[2]));
    return _list;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 16),
                TextFieldSearch(
                    label: 'Simple Future List',
                    controller: _searchController,
                    future: () {
                      return fetchFileFromAssets('assets/');
                    }),
                SizedBox(height: 16),
                TextFieldSearch(
                  label: 'Complex Future List',
                  controller: _searchController,
                  future: () {
                    return fetchData();
                  },
                  getSelectedValue: (item) {
                    print(item);
                  },
                ),
                SizedBox(height: 16),
                TextFieldSearch(
                    initialList: _list,
                    label: 'Simple List',
                    controller: _searchController),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      child: Text(
                        'Найти',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            backgroundColor: Colors.black87),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  controller: _searchController,
                  onChanged: (value) {
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}

// Mock Test Item Class
class TestItem {
  String label;
  dynamic value;

  TestItem({this.label, this.value});

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(label: json['label'], value: json['value']);
  }
}