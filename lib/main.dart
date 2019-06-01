import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  var data = await readData();

  if (data != null) {
    String message = await readData();
    print(message);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter IO',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read/Write'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
          padding: const EdgeInsets.all(13.4),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              ListTile(
                title: TextField(
                  controller: _enterDataField,
                  decoration: InputDecoration(labelText: 'Write Something'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              FlatButton(
                onPressed: () {
                  //save to file
                  writeData(_enterDataField.text);
                },
                child: Column(
                  children: <Widget>[
                    Text('Save Data'),
                    Padding(
                      padding: EdgeInsets.all(14.5),
                    ),
                    FutureBuilder(
                      future: readData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> content) {
                        if (content.hasData) {
                          return Text(
                            content.data.toString(),
                            style: TextStyle(color: Colors.blueAccent),
                          );
                        } else {
                          return Text('No data Saved!');
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  String filename = 'data.txt';
  return new File('$path/$filename');
}

Future<File> writeData(String message) async {
  final file = await _localFile;

  //write to file
  return file.writeAsString(message);
}

Future<String> readData() async {
  try {
    final file = await _localFile;

    //read file content
    String data = await file.readAsString();
    return data;
  } catch (e) {
    return "Nothing Saved Yet!!";
  }
}
