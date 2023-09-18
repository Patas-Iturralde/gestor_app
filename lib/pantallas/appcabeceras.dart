import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gestor_app/pantallas/provaider/appDirecciones.dart';

class appcabeceras extends StatelessWidget {
  const appcabeceras({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      alignment: Alignment.center,
      child: Image(
        image: NetworkImage(context.watch<appdireciones>().direcc),
      ),
    );
  }
}
