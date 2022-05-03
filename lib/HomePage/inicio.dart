import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Text("Página Principal", style: TextStyle(color: Colors.black, fontSize: 25,))
        ),
        Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: const TextField(
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
            ),
          )
        ),

        //Reemplazar esto por una ListView.builder porque es informacion que vendra de la base de datos.
        
        Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('Card title 1'),
                  subtitle: Text(
                    'Secondary Text',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('ACTION 1'),
                    ),
                    TextButton(
                      onPressed: () {
                      },
                      child: const Text('ACTION 2'),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}