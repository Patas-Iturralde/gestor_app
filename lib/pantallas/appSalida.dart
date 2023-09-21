import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class appsalida extends StatefulWidget {
  const appsalida({super.key});

  @override
  State<appsalida> createState() => _appsalidaState();
}

class _appsalidaState extends State<appsalida> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var d = const Duration(seconds: 5);
    Future.delayed(d, () {
      SystemNavigator.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      padding: const EdgeInsets.fromLTRB(40, 150, 30, 30),
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: <Color>[Color(0xffffff8d), Color(0xffb3e5fc)],
        begin: Alignment.topCenter,
      )),
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('images/logo_gadltga.png'),
              ),
              RichText(
                text: const TextSpan(
                  text: "GRACIAS POR VISITARNOS",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ],
          ),
          const Divider(
            height: 50,
            color: Colors.transparent,
          ),
        ],
      ),
    )));
  }
}
