import 'package:flutter/material.dart';
import 'package:gestor_app/pantallas/provaider/appDirecciones.dart';
import 'package:provider/provider.dart';
import 'package:gestor_app/pantallas/appBienvenida.dart';
import 'package:gestor_app/pantallas/appLogin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => appdireciones()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "inicio",
          routes: {
            "inicio": (context) => const appbienvenida(),
            "login": (context) => const applogin(),
          }),
    );
  }
}
