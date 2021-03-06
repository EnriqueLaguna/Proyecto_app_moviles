import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/Edit_Cuidados/bloc/editcuidados_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/Edit_Cuidados/item_Cuidados.dart';
import 'package:proyecto_app_moviles/Perfil/create_cuidados_item.dart';

class ShowCuidadosItem extends StatefulWidget {
  ShowCuidadosItem({Key? key}) : super(key: key);

  @override
  State<ShowCuidadosItem> createState() => _ShowCuidadosItemState();
}

class _ShowCuidadosItemState extends State<ShowCuidadosItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mis tips", style: TextStyle(color: Colors.white),)),
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/cuidado_backGround.jpeg"),
                fit: BoxFit.cover,
                colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
              )
            ),
          ),
          Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Mis tips de cuidado",
                style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              MaterialButton(
                color: Colors.lightGreen,
                child: Text("Crear nuevo tip de cuidado"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => CreateCuidadosItem())
                    )
                  );
                },
              ),
              BlocConsumer<EditcuidadosBloc, EditcuidadosState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if(!(state is EditCuidadosSuccess))
                    return Center(child: CircularProgressIndicator(),);
                  var data = state.EditData;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: RefreshIndicator(
                      onRefresh: () async => BlocProvider.of<EditcuidadosBloc>(context).add(GetAllMyDataEventCuidados()),
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
                },
              )
            ],
          ),
        ),]
      ),
    );
  }
}