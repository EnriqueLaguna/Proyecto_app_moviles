import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

part 'editcuidados_event.dart';
part 'editcuidados_state.dart';

class EditcuidadosBloc extends Bloc<EditcuidadosEvent, EditcuidadosState> {
  File? _selectedPicture;

  EditcuidadosBloc() : super(EditcuidadosInitial()) {
    on<GetAllMyDataEventCuidados>(_getAllMyData);
    on<OnEditTakePictureEvent>(_takePicture);
    on<OnEditSaveDataEvent>(_saveEditData);
  }

  FutureOr<void> _getAllMyData(event, emit) async {
      emit(EditCuidadosLoadingState());
      try{
        var queryUser = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");

        var docsRef = await queryUser.get();
        List<dynamic> listIds = docsRef.data()?["tipsListId"] ?? [];

        var queryFotos = await FirebaseFirestore.instance
          .collection("tips")
          .get();

        var allMyFotosList = queryFotos.docs
          .where((element) => listIds.contains(element.id))
          .map((e) => e.data().cast<String, dynamic>()..addAll({"docId":e.id}))
          .toList();

        emit(EditCuidadosSuccess(EditData: allMyFotosList));


      }catch(e){
        print("Error al obtener todos los items");
        emit(EditCuidadosError());
      }
    }

    FutureOr<void> _takePicture(OnEditTakePictureEvent event, emit) async {
    emit(EditCuidadosLoadingState());
    await _getImage();
    if(_selectedPicture != null){
      emit(EditFotosEditState(picture: _selectedPicture!));
    } else {
      emit(EditFotoErrorState());
    }
  }

  Future<void>_getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      _selectedPicture = File(pickedFile.path);
    } else {
      print('No image selected.');
      _selectedPicture = null;
    }
  }

  FutureOr<void> _saveEditData(OnEditSaveDataEvent event, Emitter emit) async{
    emit(EditCuidadosLoadingState());
    bool _edited = await _saveEditFshare(event.dataToSaveEdit);

    var queryUser = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");

    var docsRef = await queryUser.get();
    List<dynamic> listIds = docsRef.data()?["tipsListId"] ?? [];

    var queryFotos = await FirebaseFirestore.instance
      .collection("tips")
      .get();

    var allMyFotosList = queryFotos.docs
      .where((element) => listIds.contains(element.id))
      .map((e) => e.data().cast<String, dynamic>()..addAll({"docId":e.id}))
      .toList();

    print(_edited);
    if(_edited){
      emit(EditCuidadosSuccessState());
      emit(EditCuidadosSuccess(EditData: allMyFotosList));
    } else {
      emit(EditCuidadosSuccess(EditData: allMyFotosList));
    }
  }

  Future<bool>_saveEditFshare(Map<String, dynamic> dataToSaveEdit) async {

    try{
      //Hacer el get de la coleccion de datos
      var docRef = await FirebaseFirestore.instance.collection("tips");

      String _imageUrl = await _uploadPictureToStorage();

      //Si el usuario no toma una imagen, usar la que ya se tenia
      if(_imageUrl == ""){
        _imageUrl = dataToSaveEdit["newFotoShare"];
      }


      print(_imageUrl);

      //Update return value
      //Intentar actualizar el doc
      docRef
        .doc(dataToSaveEdit["docIdEdit"])
        .update({
          "picture":_imageUrl,
          "public":dataToSaveEdit["newPublic"],
          "title":dataToSaveEdit["newtitle"],
          "descripcion": dataToSaveEdit["newDescripcion"],
          "price": dataToSaveEdit["newPrice"],
          "publishedAt": Timestamp.fromDate(DateTime.now()),
        })
        .then((value) => print("Si se actualizo"))
        .catchError((error) => print("No se logro actualizar"));
      return true;
    }catch(e){
      print("Error al actualizar la informacion");
      return false;
    }
  }

  Future<String> _uploadPictureToStorage() async {
    try{
      var stamp = DateTime.now();
      if(_selectedPicture == null){
        return "";
      }
      UploadTask task = FirebaseStorage.instance
      .ref("tips/imagen_${stamp}.png")
      .putFile(_selectedPicture!);

      await task;

      String resultTask = await task.storage.ref("tips/imagen_${stamp}.png").getDownloadURL();

      return resultTask;

    }catch(e){
      return "";
    }
  }

}