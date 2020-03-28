import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:open_file/open_file.dart';
import 'package:trabalho_sistemas/componentes/dialog_custom.dart';
import 'package:trabalho_sistemas/componentes/flushbar_custom.dart';
import 'package:trabalho_sistemas/database/dao/materia_dao.dart';
import 'package:trabalho_sistemas/model/materias.dart';

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
  Materia materia = Materia();

  Formulario(this.materia);
}

class _FormularioState extends State<Formulario> {
  DateTime selectedDate;
  TextEditingController dataTextField = new TextEditingController();
  TextEditingController anotacaotField = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.materia.anotacoes != null){
      anotacaotField.text = widget.materia.anotacoes;
    }
    if(widget.materia.dataEscolhida != null){
      DateTime myDate = DateTime.parse(widget.materia.dataEscolhida);
      dataTextField.text = "${myDate.day}/${myDate.month}/${myDate.year}";
    }
    anotacaotField.addListener(() {
    widget.materia.anotacoes = anotacaotField.text;
    });
  }

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
                            border: Border.all(
                                width: 2.0, color: Colors.orangeAccent)),
                        child: Icon(
                          Icons.photo_camera,
                          size: 40.0,
                          color: Colors.grey,
                        )),
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
                            border: Border.all(
                                width: 2.0, color: Colors.orangeAccent)),
                        child: Icon(
                          Icons.picture_as_pdf,
                          size: 40.0,
                          color: Colors.grey,
                        )),
                    onTap: () => openFile(FileType.custom),
                  ),
                )),
                RaisedButton(
                  onPressed: () {
                    if (widget.materia.pathPdf == null ||
                        widget.materia.pathImg == null ||
                        widget.materia.anotacoes == null ||
                        widget.materia.dataEscolhida == null) {
                      FlusBarCustom(
                          "Preencha todos os campos.",
                          context,
                          Icon(
                            Icons.error,
                            color: Colors.orangeAccent,
                          )).flushbar();
                    } else {
                      saveDocuments(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.orange,
                ),
//                RaisedButton(
//                  onPressed: () {
//                    OpenFile.open(files[1].path).catchError((e) {
//                      print(e);
//                    });
//                  },
//                  child: Container(
//                    height: 50,
//                    width: 100,
//                    child: Row(
//                      children: <Widget>[
//                        Icon(
//                          Icons.open_in_browser,
//                          color: Colors.white,
//                        ),
//                        Text(
//                          "Ultimo Arquivo",
//                          style: TextStyle(color: Colors.white),
//                        ),
//                      ],
//                    ),
//                  ),
//                  color: Colors.orange,
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openFile(FileType fileType) async {
    var file = await FilePicker.getFile(type: fileType, fileExtension: "PDF");
    setState(() {
      if (fileType == FileType.image) {
        widget.materia.pathImg = file.path;
      } else {
        widget.materia.pathPdf = file.path;
      }
    });
  }

  Future<void> saveDocuments(BuildContext mContext) async {
    MateriaDao dao = MateriaDao();
    FutureBuilder(
        future: Future.delayed(Duration(seconds: 1))
            .then((value) => dao.update(widget.materia)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitSquareCircle(
                      color: Colors.orangeAccent,
                      size: 50.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Text(
                        'Carregando...',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                    )
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              DialogCustom.showCustomDialog(mContext, "Salvo com Sucesso",
                  "Dados foram salvos no lembrete", DialogType.SUCCES);
              break;
          }
          return null;
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
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (date != null) {
      selectedDate = date;
      widget.materia.dataEscolhida = date.toIso8601String();
      dataTextField.text = "${date.day}/${date.month}/${date.year}";
    }
  }
}
