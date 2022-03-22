import 'package:flutter/material.dart';
import 'package:proyecto_app_moviles/iconos.dart';

class CuidadosPage extends StatefulWidget {
  CuidadosPage({Key? key}) : super(key: key);

  @override
  State<CuidadosPage> createState() => _CuidadosPageState();
}

class _CuidadosPageState extends State<CuidadosPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(children: [
        Text("Cuidados para tus plantas", style: TextStyle(color: Colors.lightGreen, fontSize: 24, fontWeight: FontWeight.bold),),
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
          child: ListView.builder(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Iconos.flor),
                      title: Text('Consejo para Planta #${index}'),
                      subtitle: Text(
                        'Puede ser verde',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Cada vez que una planta es arrancada del suelo, puede escucharse su llanto a unos milímetros.',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('LEER'),
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.favorite))
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceEvenly,),
    );
  }
}