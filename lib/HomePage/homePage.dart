import 'package:flutter/material.dart';
import 'package:proyecto_app_moviles/Catalogo/catalogo.dart';
import 'package:proyecto_app_moviles/HomePage/inicio.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentPageIndex = 0;
  final _pageList = [
    Inicio(),
    catalogo(),
    Center(child: Text("Pagina 3"),),
    Center(child: Text("Pagina 4"),),
  ];

  final _namePageList = [
    "Inicio",
    "Catalogo",
    "Cuidados",
    "Mi perfil",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Proyecto Moviles'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
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
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentPageIndex,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
            label: _namePageList[0],
            icon: Icon(Icons.home),
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