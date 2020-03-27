import 'package:flutter/material.dart';

class CardMateria extends StatelessWidget {
  String nomeMateria;

  CardMateria(this.nomeMateria);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: Container(
        height: 75,
        width:  MediaQuery.of(context).size.width * 0.8,
        child: Card(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.library_books,
                color: Colors.orange,
                size: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(nomeMateria),
              )
            ],
          )
        ),
      ),
    );
  }
}
