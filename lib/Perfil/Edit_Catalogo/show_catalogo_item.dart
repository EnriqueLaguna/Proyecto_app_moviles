import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/Edit_Catalogo/bloc/editcatalogo_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/Edit_Catalogo/item_Catalogo.dart';

class ShowCatalogoItem extends StatefulWidget {
  ShowCatalogoItem({Key? key}) : super(key: key);

  @override
  State<ShowCatalogoItem> createState() => _ShowCatalogoItemState();
}

class _ShowCatalogoItemState extends State<ShowCatalogoItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ver objetos catalogo")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Mi catalogo de plantas",
              style: TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            BlocConsumer<EditcatalogoBloc, EditcatalogoState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if(!(state is EditCatalogoSuccess))
                  return Center(child: CircularProgressIndicator(),);
                var data = state.EditData;
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: RefreshIndicator(
                    onRefresh: () async => BlocProvider.of<EditcatalogoBloc>(context).add(GetAllMyDataEvent()),
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
                          return ItemCatalogo(allCatalogoData: data[index],);
                        }),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}