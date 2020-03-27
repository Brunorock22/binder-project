import 'dart:convert';
import 'dart:io';


import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_sistemas/screens/calendar.dart';
import 'package:trabalho_sistemas/screens/lista_materias.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
  static int pos = 0;
}

class _BottomNavBarState extends State<BottomNavBar> {




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  void showPageByNotification(Map map) {
    bool b = map.containsKey("screen");
    if (b) {
      int id = int.parse(map["click_action_id"]);
      String screen = map["screen"];

      switch (screen) {
        case "noticia":
        //Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsScreen.fromID(id)));
          break;
        case "chamado_status":
        //Navigator.push(context, MaterialPageRoute(builder: (context) => MyCallsDetailsScreen.fromID(id)));
          break;
        case "notificacao":
          break;
        case "cidadao":
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalMessageDetailsScreen(id)));
          break;
      }
    }
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      Map map = json.decode(payload);
      showPageByNotification(map);
      debugPrint('Notification payload: $payload');
    }
//    await Navigator.push(context,
//        new MaterialPageRoute(builder: (context) => new SecondRoute()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
//            onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                new MaterialPageRoute(
//                  builder: (context) => new SecondScreen(payload),
//                ),
//              );
//            },
          )
        ],
      ),
    );
  }



  List<TabItem> tabItems = List.of([
    new TabItem(Icons.calendar_today, "Calendario", Colors.black54,
        labelStyle:
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    new TabItem(Icons.book, "Materias", Colors.orange,
        labelStyle: TextStyle(color: Colors.orange)),

  ]);

  CircularBottomNavigationController _navigationController =
  CircularBottomNavigationController(BottomNavBar.pos);

  Widget page;

  @override
  Widget build(BuildContext context) {
    page ??= CalendarCustom();
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orangeAccent,
        accentColor: Colors.black,
        backgroundColor: Colors.orange,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orangeAccent,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Scaffold(
        body: page,
        bottomNavigationBar: CircularBottomNavigation(
          tabItems,
          controller: _navigationController,
          selectedCallback: (int selectedPos) {
            callPage(selectedPos);
          },
          barBackgroundColor: Colors.white70,
        ),
      ),
    );
  }

  void callPage(int selectedPos) {
    setState(() {
      BottomNavBar.pos = selectedPos;
      switch (BottomNavBar.pos) {
        case 0:
          page = CalendarCustom();
          break;
        case 1:
          page = ListaMaterias();
          break;

      }
    });
  }
}
