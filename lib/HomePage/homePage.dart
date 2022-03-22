import 'package:flutter/material.dart';
import 'package:proyecto_app_moviles/Catalogo/catalogo.dart';
import 'package:proyecto_app_moviles/Cuidados/cuidado.dart';
import 'package:proyecto_app_moviles/HomePage/inicio.dart';
import 'package:proyecto_app_moviles/Login/login.dart';
import 'package:proyecto_app_moviles/Register/register.dart';
import 'package:proyecto_app_moviles/iconos.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentPageIndex = 0;
  final _pageList = <Widget>[
    Inicio(),
    catalogo(),
    CuidadosPage(),
    LoginPage()
  ];

  final _namePageList = [
    "Inicio",
    "Catálogo",
    "Cuidados",
    "Mi perfil",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Proyecto Móviles', style: TextStyle(color: Colors.yellow[50]),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.yellow[50],),
            onPressed: () {
              //do something
            },
          )
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightGreen,
        selectedItemColor: Colors.yellow[400],
        unselectedItemColor: Colors.yellow[50],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          _currentPageIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            label: _namePageList[0],
            icon: Icon(Iconos.flor,),
          ),
          BottomNavigationBarItem(
            label: _namePageList[1],
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: _namePageList[2],
            icon: Icon(Icons.warning),
          ),
          BottomNavigationBarItem(
            label: _namePageList[3],
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}