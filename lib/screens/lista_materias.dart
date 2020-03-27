import 'package:flutter/material.dart';
import 'package:trabalho_sistemas/componentes/card_materia.dart';
import 'package:trabalho_sistemas/model/materias.dart';
import 'package:trabalho_sistemas/screens/formulario_upload.dart';

class ListaMaterias extends StatefulWidget {
  @override
  _ListaMateriasState createState() => _ListaMateriasState();
}

class _ListaMateriasState extends State<ListaMaterias> {
  List<Materia> listMaterias = List();
  TextEditingController nomeMateriaController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: listMaterias.length,
          itemBuilder: (context, indice) {
            return GestureDetector(
              child: CardMateria(listMaterias[indice].nome),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Formulario()))
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DialogSalvar(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void DialogSalvar(BuildContext context) {
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
                            listMaterias
                                .add(Materia(nomeMateriaController.text));
                            nomeMateriaController.text = "";
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.orange,
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
