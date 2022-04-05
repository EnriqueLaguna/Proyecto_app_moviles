import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Login/auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passwordController = TextEditingController();
  final borde = OutlineInputBorder(borderSide: BorderSide(color: Colors.lightGreen));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          const Text("Nombre de la aplicación", style: TextStyle(fontWeight: FontWeight.bold),),
          TextFormField(
            decoration: InputDecoration(
              border: borde,
              enabledBorder: borde,
              focusedBorder: borde,
              labelText: "Correo electrónico",
              floatingLabelStyle: TextStyle(color: Colors.green),
            ),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              border: borde,
              enabledBorder: borde,
              focusedBorder: borde,
              labelText: "Contraseña",
              //suffix: IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye)),
              floatingLabelStyle: TextStyle(color: Colors.green),
            ),
          ),
          MaterialButton(
            onPressed: (){},
            child: Text("¿No tienes cuenta? Regístrate aquí", style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold),)
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.75,
            child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              ElevatedButton(
                onPressed: (){}, 
                child: const ListTile(title: Text("Iniciar Sesión", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(150),),
                    )
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(
                onPressed: (){
                  BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(150),),
                      side: BorderSide(color: Theme.of(context).primaryColor,width: 2,style: BorderStyle.solid),
                    )
                  ),
                ),
                child: const ListTile(
                  leading: Icon(Icons.g_mobiledata, size: 36,),
                  title: Text("Iniciar con Google", style: TextStyle(color: Colors.grey), textAlign: TextAlign.start,),
                )
              ),
            ],),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,),
      ),
    );
  }
}