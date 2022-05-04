import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/Edit_Catalogo/bloc/editcatalogo_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/create_catalogo_item.dart';
import 'package:proyecto_app_moviles/Perfil/Edit_Catalogo/show_catalogo_item.dart';
import 'package:proyecto_app_moviles/Perfil/create_cuidados_item.dart';
import 'package:proyecto_app_moviles/Perfil/Edit_Cuidados/bloc/editcuidados_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/Edit_Cuidados/show_cuidados_item.dart';


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
          Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height *.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/perfil_background.jpg"),
                fit: BoxFit.cover

              )
            ),
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
                Text(user.email.toString(), style: TextStyle(color: Colors.black54),),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              BlocProvider.of<EditcatalogoBloc>(context).add(GetAllMyDataEvent());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => ShowCatalogoItem())
                )
              );
            },
            child:
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/catalogo_backGround.jpg"),
                    fit: BoxFit.cover,
                    colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                  )
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .2527,              
                child: Center(
                  child: Container(
                    child: Text("Mi catalogo", style: TextStyle(color: Colors.white70, fontSize: 40, fontStyle: FontStyle.italic,),),
                  ),
                ),
              ),
              
          ),
          GestureDetector(
            onTap: (){
              BlocProvider.of<EditcuidadosBloc>(context).add(GetAllMyDataEventCuidados());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => ShowCuidadosItem())
                )
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/cuidado_backGround.jpeg"),
                  fit: BoxFit.cover,
                  colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                )
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .2527,
              child: Center(
                  child: Container(
                    child: Text("Mis tips", style: TextStyle(color: Colors.white70, fontSize: 40, fontStyle: FontStyle.italic,),),
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}

// MaterialButton(
//   color: Colors.lightGreen,
//   child: Text("Crear nuevo tip de cuidado"),
//   onPressed: (){
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: ((context) => CreateCuidadosItem())
//       )
//     );
//   },
// ),

// MaterialButton(
//   color: Colors.lightGreen,
//   child: Text("Agregar planta al catálogo"),
//   onPressed: (){
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: ((context) => CreateCatalogoItem())
//       )
//     );
//   },
// ),