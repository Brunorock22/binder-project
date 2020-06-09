import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    /*animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });*/

    controller.forward();
  }

  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        child: FadeTransition(
            opacity: animation,
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Image.asset("assets/images/icon_pita.jpg")
                      ),
                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(top: 100.0),
//                      child: Text("Developed by Bruno Camargos",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11,color: Colors.black54),),
//                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}