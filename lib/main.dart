import 'package:flutter/material.dart';
import 'package:proyecto_app_moviles/HomePage/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage()
    );
  }
}
