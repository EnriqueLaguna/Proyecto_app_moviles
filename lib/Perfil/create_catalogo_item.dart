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
  bool _defaultSwitchValue = false;
  File? image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCatalogoBloc, CreateCatalogoState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is CreatePictureErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al elegir imagen valida..."))
          );
        } else if(state is CreateCatalogoErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al guardar la fshare"))
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
            title: Text("Nuevo objeto catalogo"),
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
                MaterialButton(
                  child: Text("Foto"), 
                  onPressed: () {
                    BlocProvider.of<CreateCatalogoBloc>(context).add(OnCreateTakePictureEvent());
                  }
                ),
                Padding(
                  padding: EdgeInsetsDirectional.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(10.0),
                        child: Text("Titulo del nuevo item"),
                      ),
                      TextField(
                        controller: _catalogueItemName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.all(10.0),
                        child: Text("Descripcion del nuevo item"),
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
                        child: Text("Precio del nuevo item"),
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
                  child: Text("Guardar"),
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
