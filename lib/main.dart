import 'package:flutter/material.dart';
import 'package:fifa/views/ventanaLogin.dart';
import 'package:fifa/views/ventanaPrincipal.dart';
import 'package:fifa/views/ventanaRegistro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePageVentanaLogin(title: 'FIFA 2026'),
        'principal': (context) => const MyHomePageVentanaPrincipal(),
        'registro': (context) => const MyHomePageVentanaRegistro(),
      },
    );
  }
}