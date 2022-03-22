import 'package:flutter/material.dart';
import 'package:proyecto_app_moviles/HomePage/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: HomePage()
    );
  }
}