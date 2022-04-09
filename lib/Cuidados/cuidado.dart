import 'package:flutter/material.dart';
import 'package:proyecto_app_moviles/iconos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Cuidados/bloc/cuidados_bloc.dart';
import 'package:proyecto_app_moviles/Cuidados/item_Cuidados.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Tips para cuidados de plantas",
            style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          TextFormField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: "Nombre de la planta..",
              isDense: true,
              suffixIcon: MaterialButton(onPressed: (){}, child: Text("BUSCAR", style: TextStyle(color: Colors.yellow[700]),),),
            ),
          ),
          BlocConsumer<CuidadosBloc, CuidadosState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if(state is CuidadosError){
                return Center(child: CircularProgressIndicator(),);
              } else if (state is CuidadosSuccess){
                var data = state.data;
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: RefreshIndicator(
                    onRefresh: () async => BlocProvider.of<CuidadosBloc>(context).add(CuidadosGetEvent()),
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20.0,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.7),
                        ),
                        itemBuilder: (BuildContext context, index) {
                          return ItemCuidados(allCuidadosData: data[index],);
                        }),
                  ),
                );
              } else {
                return Text("Se murio");
              }
            },
          ),
      ],),
    );
  }
}