import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

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
  @override
  Widget build(BuildContext context) {
    return Container();
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
}
