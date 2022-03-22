import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final passwordController = TextEditingController();
  final borde = OutlineInputBorder(borderSide: BorderSide(color: Colors.lightGreen));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(children: [
        const Text("Nombre de la aplicación", style: TextStyle(fontWeight: FontWeight.bold),),
        TextFormField(
          decoration: InputDecoration(
            border: borde,
            enabledBorder: borde,
            focusedBorder: borde,
            labelText: "Nombre",
            //floatingLabelStyle: TextStyle(color: Colors.green),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: borde,
            enabledBorder: borde,
            focusedBorder: borde,
            labelText: "Correo electrónico",
            // floatingLabelStyle: TextStyle(color: Colors.green),
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
            // floatingLabelStyle: TextStyle(color: Colors.green),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.75,
          child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            ElevatedButton(
              onPressed: (){}, 
              child: const ListTile(title: Text("¡Registrarse!", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)),
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all(Colors.green),
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
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(150),),
                    side: BorderSide(color: Theme.of(context).primaryColor,width: 2,style: BorderStyle.solid),
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,),
    );
  }
}