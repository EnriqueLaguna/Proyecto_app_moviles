import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("Nombre de la aplicación", style: TextStyle(fontWeight: FontWeight.bold),),
      TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          labelText: "Nombre",
          floatingLabelStyle: TextStyle(color: Colors.green),
        ),
      ),
      TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          labelText: "Correo electrónico",
          floatingLabelStyle: TextStyle(color: Colors.green),
        ),
      ),
      TextFormField(
        controller: passwordController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          labelText: "Contraseña",
          //suffix: IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye)),
          floatingLabelStyle: TextStyle(color: Colors.green),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width*0.75,
        child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          ElevatedButton(
            onPressed: (){}, 
            child: const ListTile(title: Text("¡Registrarse!", textAlign: TextAlign.center,)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(150),),
                  //side: BorderSide(color: Colors.green,width: 2,style: BorderStyle.solid),
                )
              ),
            ),
          ),
          const SizedBox(height: 10,),
          TextButton(
            onPressed: (){},
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(150),),
                  side: BorderSide(color: Colors.green,width: 2,style: BorderStyle.solid),
                )
              ),
            ),
            child: const ListTile(
              leading: Icon(Icons.g_mobiledata, size: 36,),
              title: Text("Registrarse con Google", style: TextStyle(color: Colors.grey), textAlign: TextAlign.start,),
            )
          ),
        ],),
      )
    ],
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,);
  }
}