import 'package:flutter/material.dart';
import 'package:proyecto_app_moviles/Catalogo/item_Catalogo.dart';

class Catalogo extends StatefulWidget {
  const Catalogo({Key? key}) : super(key: key);

  @override
  State<Catalogo> createState() => _CatalogoState();
}

class _CatalogoState extends State<Catalogo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Catalogo de plantas", style: TextStyle(color: Colors.lightGreen, fontSize: 24, fontWeight: FontWeight.bold),),
          TextFormField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: "Nombre de la planta..",
              isDense: true,
              suffixIcon: MaterialButton(onPressed: (){}, child: Text("BUSCAR", style: TextStyle(color: Colors.yellow[700]),),),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.5,
            child: GridView.builder(
              itemCount: 10,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.7),
              ),
              itemBuilder: (BuildContext context, index){
                return ItemCatalogo();
              }),
          )
          
        ],
      ),
    );
  }
}