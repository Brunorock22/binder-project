import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trabalho_sistemas/screens/splash_config.dart';

import 'componentes/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Agenda Crista';

  @override
  Widget build(BuildContext mContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor: Color.fromARGB(255, 242, 171, 80),
        accentColor: Color.fromARGB(255, 188, 124, 32),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black,
          textTheme: ButtonTextTheme.accent,

        ),
      ),
      title: appTitle,
      supportedLocales: [const Locale('pt', 'BR')],
      initialRoute: '/main' ,
      routes: {
        '/main' : (mContext) => SplashConfig(),

      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}