import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  DateTime selectedDate;
  TextEditingController dataTextField = new TextEditingController();
  TextEditingController anotacaotField = new TextEditingController();
  List<File> files = List();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.orangeAccent[800],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: dataTextField,
                    readOnly: true,
                    style: TextStyle(color: Colors.orange),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_today,
                      ),
                      hintStyle: TextStyle(color: Colors.black12),
                      labelText: "Data",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0)),
                    ),
                    onTap: () => datePicker(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: anotacaotField,
                    style: TextStyle(color: Colors.orange),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.text_fields,
                      ),
                      hintStyle: TextStyle(color: Colors.black12),
                      labelText: "Descrição de anatoções",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0)),
                    ),
                    onTap: () => print(anotacaotField.text),
                  ),
                ),
                Center(
                    child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: GestureDetector(
                    child: Container(

                      height: 100,
                        width: 100,
                        foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all( width: 2.0,color: Colors.orangeAccent)),
                        child: Icon(Icons.photo_camera
                        ,size: 40.0,color: Colors.grey,)),
                    onTap: () => openFile(FileType.image),
                  ),
                )),
                Center(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: GestureDetector(
                        child: Container(

                            height: 100,
                            width: 100,
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all( width: 2.0,color: Colors.orangeAccent)),
                            child: Icon(Icons.picture_as_pdf
                              ,size: 40.0,color: Colors.grey,)),
                        onTap: () => openFile(FileType.custom),
                      ),
                    )),
                RaisedButton(
                  onPressed: () {
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    child: Row(
                     children: <Widget>[
                       Icon(Icons.save,color: Colors.white,),
                       Text(
                         "Salvar",
                         style: TextStyle(color: Colors.white),
                       ),
                     ],
                    ),
                  ),
                  color: Colors.orange,
                ),
                RaisedButton(
                  onPressed: () {
                    OpenFile.open(files[1].path).catchError((e){
                      print(e);
                    });

                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.open_in_browser,color: Colors.white,),
                        Text(
                          "Abrir Arquivo",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
    void openFile(FileType fileType) async{
       var file = await FilePicker.getFile(type:fileType,fileExtension: "PDF");
       files.add(file);
       setState(() {
        print(files);
      });
  }



  void datePicker(BuildContext mContext) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (date != null) {
      selectedDate = date;
      dataTextField.text = "${date.day}/${date.month}/${date.year}";
    }
  }
}
