import 'package:flutter/material.dart';

import 'package:gestor_app/pantallas/appRegisExpe.dart';

class appbienvenida extends StatefulWidget {
  const appbienvenida({super.key});

  @override
  State<appbienvenida> createState() => _appbienvenidaState();
}

class _appbienvenidaState extends State<appbienvenida> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var d = const Duration(seconds: 5);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const appRegisExpe()),
          (route) => false);
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
              Image.network('http://186.46.158.7/appImagenes/logo_gadltga.png'),
            ],
          ),
          const Divider(
            height: 50,
            color: Colors.transparent,
          ),
          const LinearProgressIndicator(
            backgroundColor: Color.fromARGB(255, 110, 184, 233),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
          ),
        ],
      ),
    )));
  }
}
