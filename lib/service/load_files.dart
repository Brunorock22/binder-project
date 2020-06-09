import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';



class LoadFiles extends StatefulWidget {
  @override
  _LoadFilesState createState() => new _LoadFilesState();
}

class _LoadFilesState extends State<LoadFiles> {
  String _openResult = 'Unknown';

  Future<void> openFile() async {

    List<File> files = await FilePicker.getMultiFile();

    setState(() {
      print(files);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('open result: $_openResult\n'),
              FlatButton(
                child: Text('Tap to open file'),
                onPressed: openFile,
              ),
            ],
          ),
        )
    );
  }
}