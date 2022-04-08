import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_app_moviles/Perfil/create_catalogo_item.dart';

class Perfil extends StatefulWidget {
  Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return Center(
      child: Column(
        children: [
          SizedBox(height: 16,),
          CircleAvatar(
            foregroundImage: NetworkImage(user.photoURL.toString()),
            radius: 64,
          ),
          SizedBox(height: 16,),
          Text(user.displayName.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
          SizedBox(height: 8,),
          Text(user.email.toString(), style: TextStyle(color: Colors.grey),),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Colors.lightGreen,
              child: Text("Agregar planta al catalogo"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => CreateCatalogoItem())
                  )
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
