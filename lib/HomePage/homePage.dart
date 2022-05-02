import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Catalogo/catalogo.dart';
import 'package:proyecto_app_moviles/Cuidados/cuidado.dart';
import 'package:proyecto_app_moviles/HomePage/inicio.dart';
import 'package:proyecto_app_moviles/Login/auth/bloc/auth_bloc.dart';
import 'package:proyecto_app_moviles/Mapa/mapa.dart';
import 'package:proyecto_app_moviles/Pago/pago.dart';
import 'package:proyecto_app_moviles/Perfil/perfPage.dart';
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
    Catalogo(),
    CuidadosPage(),
    Perfil(),
    Mapa(),
  ];

  final _namePageList = [
    "Inicio",
    "Catálogo",
    "Cuidados",
    "Mi perfil",
    "Rastreo"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Proyecto Móviles', style: TextStyle(color: Colors.yellow[50]),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, color: Colors.yellow[50],),
            onPressed: () {
              //Log out del usuario
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());

            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => Pago()));
        },
        child: Icon(Icons.yard),
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
          BottomNavigationBarItem(
            label: _namePageList[4],
            icon: Icon(Icons.map),
          ),
        ],
      ),
    );
  }
}