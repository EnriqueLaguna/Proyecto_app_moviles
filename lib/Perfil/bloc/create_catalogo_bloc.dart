import 'dart:io';
import 'dart:async' ;

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

part 'create_catalogo_event.dart';
part 'create_catalogo_state.dart';

class CreateCatalogoBloc extends Bloc<CreateCatalogoEvent, CreateCatalogoState> {
  File? _selectedPicture;
  
  CreateCatalogoBloc() : super(CreateCatalogoInitial()) {
    on<OnCreateTakePictureEvent>(_takePicture);
    on<OnCreateSaveDataEvent>(_saveData);
  }

  FutureOr<void> _saveData(OnCreateSaveDataEvent event, Emitter emit) async {
    emit(CreateLoadingState());
    bool _saved = await _saveFshare(event.dataToSave);

    if(_saved){
      emit(CreateSuccessState());
    } else {
      emit(CreateCatalogoErrorState());
    }
  }

  Future<bool> _saveFshare(Map<String, dynamic> dataToSave) async {
    try{
      //Subir imagen al bucket de firebase storage
      String _imageUrl = await _uploadPictureToStorage();
      if(_imageUrl != ""){
        dataToSave["picture"] = _imageUrl;
        dataToSave["publishedAt"] = Timestamp.fromDate(DateTime.now());
        dataToSave["seller"] = FirebaseAuth.instance.currentUser!.displayName;
      }else {
        return false;
      }

      print(dataToSave);

      var docRef = await FirebaseFirestore.instance
        .collection("catalogue")
        .add(dataToSave);

      return await _updateUserDocumentReference(docRef.id);
    }catch(e){
      print("Muerte: $e");
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
      .ref("catalogue/imagen_${stamp}.png")
      .putFile(_selectedPicture!);

      await task;

      String resultTask = await task.storage.ref("catalogue/imagen_${stamp}.png").getDownloadURL();

      return resultTask;


    }catch(e){
      return "";
    }
  }

  
  Future<bool> _updateUserDocumentReference(String catalogueId) async {
    try{
      var queryUser = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await queryUser.get();
      List<dynamic> listIds = docsRef.data()?["catalogueListId"];

      listIds.add(catalogueId);

      await queryUser.update({"catalogueListId": listIds});
      return  true;
    }catch(e){
      print("Error en actualizar doc: $e");
      return false;
    }
  }

  FutureOr<void> _takePicture(OnCreateTakePictureEvent event, emit) async {
    emit(CreateLoadingState());
    await _getImage(event.isCamera);
    if(_selectedPicture != null){
      emit(CreatePictureChangedState(picture: _selectedPicture!));
    } else {
      emit(CreatePictureErrorState());
    }
  }

  Future<void>_getImage(bool isCamera) async {
    final pickedFile = await ImagePicker().pickImage(
      source: isCamera?ImageSource.camera:ImageSource.gallery,
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

}
