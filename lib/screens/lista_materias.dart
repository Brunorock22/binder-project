import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trabalho_sistemas/componentes/card_materia.dart';
import 'package:trabalho_sistemas/database/dao/materia_dao.dart';
import 'package:trabalho_sistemas/model/materias.dart';
import 'package:trabalho_sistemas/screens/formulario_upload.dart';
import 'package:trabalho_sistemas/util/colors_util.dart';

class ListaMaterias extends StatefulWidget {
  @override
  _ListaMateriasState createState() => _ListaMateriasState();
}

class _ListaMateriasState extends State<ListaMaterias> {
  TextEditingController nomeMateriaController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    MateriaDao dao = MateriaDao();

    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 1)).then((value) => dao.findAll()),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitSquareCircle(

                color: ColorUtils.accentColor,
                  size: 50.0,
                ),
                    Padding(
                      padding: const EdgeInsets.only(top : 35.0),
                      child: Text('Carregando...',style: TextStyle(fontSize: 14,color: ColorUtils.accentColor),),
                    )
                  ],
                ),
              );
              break;
            case ConnectionState.active:
                break;
            case ConnectionState.done:
              final List<Materia> materias = snapshot.data;
              return ListView.builder(
                  itemCount: materias.length,
                  itemBuilder: (context, indice) {
                    final Materia materia = materias[indice];
                    return GestureDetector(
                        child: CardMateria(materia),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Formulario(materia)))
                    );
                  });
              break;
          }
          return null;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DialogSalvar(context,dao);
        },
        child: Icon(Icons.add),
        backgroundColor: ColorUtils.primaryColor,
      ),
    );
  }

  void DialogSalvar(BuildContext context,MateriaDao dao) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nomeMateriaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Materia',
                      ),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          print(nomeMateriaController.text);
                          setState(() {
                            dao.save(Materia( nomeMateria: nomeMateriaController.text)).then((value){
                              print(value);
                            });
                            nomeMateriaController.text = "";
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: ColorUtils.accentColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
