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
      appBar: AppBar(
        title: Text('Oxygen To U', style: TextStyle(color: Colors.white),),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/loginBackground.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  image: AssetImage("assets/images/plant-pot.png"),
                  height: 300,
                  width: 300,
                )
              ),
              Center(
                child: MaterialButton(
                  hoverColor: Color.fromARGB(255, 17, 61, 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.g_mobiledata_outlined, color: Colors.white, size: 40,),
                      SizedBox(width: 20,),
                      Text("Iniciar con Google", style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  color: Colors.red,
                  minWidth: MediaQuery.of(context).size.width - 30,
                  onPressed: (){
                    BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                  }
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}