import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'componentes/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Agenda Crista';

  @override
  Widget build(BuildContext mContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor: Colors.black,
        accentColor: Colors.orangeAccent,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black,
          textTheme: ButtonTextTheme.accent,

        ),
      ),
      title: appTitle,
      supportedLocales: [const Locale('pt', 'BR')],
      initialRoute: '/main' ,
      routes: {
        '/main' : (mContext) => BottomNavBar(),

      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}