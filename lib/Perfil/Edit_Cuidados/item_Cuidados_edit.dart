import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/Edit_Cuidados/bloc/editcuidados_bloc.dart';
import 'package:proyecto_app_moviles/Perfil/bloc/create_cuidados_bloc.dart';

class MisCuidadosEdit extends StatefulWidget {
  const MisCuidadosEdit(
      {Key? key,
      required this.docIdString,
      required this.switchCurrentValue,
      required this.currentImage,
      required this.currentName,
      required this.currentDescription,
      })
      : super(key: key);

  //String con el id del doc que quiero editar
  final String docIdString;
  final bool switchCurrentValue;
  final String currentImage;
  final String currentName;
  final String currentDescription;

  @override
  State<MisCuidadosEdit> createState() => _MisCuidadosEdit();
}

class _MisCuidadosEdit extends State<MisCuidadosEdit> {
  var _newTitleC = TextEditingController();
  var _newDescription = TextEditingController();
  bool _defaultSwitchValue = false;
  File? image;

  @override
  void initState() {
    _defaultSwitchValue = widget.switchCurrentValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditcuidadosBloc, EditcuidadosState>(
      listener: (context, state) {

        // TODO: implement listener
        if(state is EditFotosEditState){
          image = state.picture;
        } else if(state is EditFotoErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al elegir imagen valida..."))
          );
        } else if(state is EditErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al editar la fshare"))
          );
        }else if(state is EditCuidadosSuccessState){
          _newTitleC.clear();
          _defaultSwitchValue = false;
          image = null;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Editar"),
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
                image == null?
                  Image.network(
                    widget.currentImage,
                    height: 240,
                    width: 240,
                  ):
                  Image.file(
                    image!,
                    height: 240,
                    width: 240,
                  ),
                Row(
                  children: [
                    TextButton(
                      child: Text("Tomar foto"), 
                      onPressed: () {
                        BlocProvider.of<EditcuidadosBloc>(context).add(OnEditTakePictureEvent(isCamera: true));
                      }
                    ),
                    SizedBox(width: 30,),
                    TextButton(
                      child: Text("Elegir foto"), 
                      onPressed: () {
                        BlocProvider.of<EditcuidadosBloc>(context).add(OnEditTakePictureEvent(isCamera: false));
                      }
                    ),
                  ],mainAxisAlignment: MainAxisAlignment.center,
                ),
                TextField(
                  controller: _newTitleC,
                  decoration: InputDecoration(
                    label: Text("${widget.currentName}"),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: _newDescription,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Descripcion",
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
                MaterialButton(
                  child: Text("Editar"),
                  color: Colors.lightGreen,
                  onPressed: () {
                    Map<String, dynamic> fshareEditData = {
                      "newtitle": _newTitleC.value.text,
                      "newDescripcion": _newDescription.value.text,
                      "newPublic": _defaultSwitchValue,
                      "newFotoShare": image == null? widget.currentImage : image!.path,
                      "docIdEdit": widget.docIdString,
                    };
                    BlocProvider.of<EditcuidadosBloc>(context).add(OnEditSaveDataEvent(dataToSaveEdit: fshareEditData));

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