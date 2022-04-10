import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/bloc/create_cuidados_bloc.dart';

class CreateCuidadosItem extends StatefulWidget {
  CreateCuidadosItem({Key? key}) : super(key: key);

  @override
  State<CreateCuidadosItem> createState() => _CreateCuidadosItemState();
}

class _CreateCuidadosItemState extends State<CreateCuidadosItem> {
  var _TipsItemName = TextEditingController();
  var _TipsItemDescription = TextEditingController();
  bool _defaultSwitchValue = false;
  File? image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCuidadosBloc, CreateCuidadosState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is CreatePictureErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al elegir imagen valida..."))
          );
        } else if(state is CreateCuidadosErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al guardar la fshare"))
          );
        }else if(state is CreateSuccessState){
          _TipsItemName.clear();
          _TipsItemDescription.clear();
          _defaultSwitchValue = false;
          image = null;
        } else if(state is CreatePictureChangedState){
          image = state.picture;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Nuevo tip de cuidado"),
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
                    BlocProvider.of<CreateCuidadosBloc>(context).add(OnCreateTakePictureEvent());
                  }
                ),
                Padding(
                  padding: EdgeInsetsDirectional.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(10.0),
                        child: Text("Titulo del nuevo tip de cuidado"),
                      ),
                      TextField(
                        controller: _TipsItemName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.all(10.0),
                        child: Text("Descripcion del nuevo tip de cuidado"),
                      ),
                      TextField(
                        controller: _TipsItemDescription,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
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
                    Map<String, dynamic> TipsData = {
                      "title": _TipsItemName.value.text,
                      "description": _TipsItemDescription.value.text,
                      "public": _defaultSwitchValue,
                    };

                    BlocProvider.of<CreateCuidadosBloc>(context)
                        .add(OnCreateSaveDataEvent(dataToSave: TipsData));
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