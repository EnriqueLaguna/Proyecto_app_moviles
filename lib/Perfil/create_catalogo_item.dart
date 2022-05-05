import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/bloc/create_catalogo_bloc.dart';

class CreateCatalogoItem extends StatefulWidget {
  CreateCatalogoItem({Key? key}) : super(key: key);

  @override
  State<CreateCatalogoItem> createState() => _CreateCatalogoItemState();
}

class _CreateCatalogoItemState extends State<CreateCatalogoItem> {
  var _catalogueItemName = TextEditingController();
  var _catalogueItemPrice = TextEditingController();
  var _catalogueItemDescription = TextEditingController();
  bool _defaultSwitchValue = true;
  File? image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCatalogoBloc, CreateCatalogoState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is CreatePictureErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al seleccionar la imagen.",style: TextStyle(color: Colors.brown[900]),),backgroundColor: Colors.amber,)
          );
        } else if(state is CreateCatalogoErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al guardar el elemento.",style: TextStyle(color: Colors.brown[900]),),backgroundColor: Colors.amber,)
          );
        }else if(state is CreateSuccessState){
          _catalogueItemName.clear();
          _catalogueItemDescription.clear();
          _catalogueItemPrice.clear();
          _defaultSwitchValue = false;
          image = null;
        } else if(state is CreatePictureChangedState){
          image = state.picture;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Nuevo objeto de catálogo"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Container(
                  child: Text("Imagen",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24)),
                ),
                SizedBox(
                  height: 20,
                ),
                image != null
                    ? Image.file(
                        image!,
                        height: 120,
                      )
                    : Container(),
                Row(
                  children: [
                    TextButton(
                      child: Text("Tomar foto"), 
                      onPressed: () {
                        BlocProvider.of<CreateCatalogoBloc>(context).add(OnCreateTakePictureEvent(isCamera: true));
                      }
                    ),
                    SizedBox(width: 30,),
                    TextButton(
                      child: Text("Elegir foto"), 
                      onPressed: () {
                        BlocProvider.of<CreateCatalogoBloc>(context).add(OnCreateTakePictureEvent(isCamera: false));
                      }
                    ),
                  ],mainAxisAlignment: MainAxisAlignment.center,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(10.0),
                        child: Text("Título del nuevo ítem"),
                      ),
                      TextField(
                        controller: _catalogueItemName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.all(10.0),
                        child: Text("Descripción del nuevo ítem"),
                      ),
                      TextField(
                        controller: _catalogueItemDescription,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.all(10.0),
                        child: Text("Precio del nuevo ítem"),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _catalogueItemPrice,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SwitchListTile.adaptive(
                          title: Text("Publicar"),
                          value: _defaultSwitchValue,
                          onChanged: (newValue) {
                            _defaultSwitchValue = newValue;
                            setState(() {});
                          }),
                    ],
                  ),
                ),
                MaterialButton(
                  child: Text("Guardar", style: TextStyle(color: Colors.yellow[50]),),
                  color: Colors.lightGreen,
                  onPressed: () {
                    Map<String, dynamic> CatalogueData = {
                      "title": _catalogueItemName.value.text,
                      "description": _catalogueItemDescription.value.text,
                      "price": int.parse(_catalogueItemPrice.value.text),
                      "public": _defaultSwitchValue,
                    };

                    BlocProvider.of<CreateCatalogoBloc>(context)
                        .add(OnCreateSaveDataEvent(dataToSave: CatalogueData));
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
