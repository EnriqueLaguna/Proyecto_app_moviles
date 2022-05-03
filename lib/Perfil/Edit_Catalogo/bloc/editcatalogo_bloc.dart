import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

part 'editcatalogo_event.dart';
part 'editcatalogo_state.dart';

class EditcatalogoBloc extends Bloc<EditcatalogoEvent, EditcatalogoState> {
  File? _selectedPicture;

  EditcatalogoBloc() : super(EditcatalogoInitial()) {
    on<GetAllMyDataEvent>(_getAllMyData);
    on<OnEditTakePictureEvent>(_takePicture);
    on<OnEditSaveDataEvent>(_saveEditData);
    on<OnDeleteItemEvent>(_deleteItem);
  }

  FutureOr<void> _getAllMyData(event, emit) async {
      emit(EditCatalogoLoadingState());
      try{
        var queryUser = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");

        var docsRef = await queryUser.get();
        List<dynamic> listIds = docsRef.data()?["catalogueListId"] ?? [];

        var queryFotos = await FirebaseFirestore.instance
          .collection("catalogue")
          .get();

        var allMyFotosList = queryFotos.docs
          .where((element) => listIds.contains(element.id))
          .map((e) => e.data().cast<String, dynamic>()..addAll({"docId":e.id}))
          .toList();

        emit(EditCatalogoSuccess(EditData: allMyFotosList));
        

      }catch(e){
        print("Error al obtener todos los items");
        emit(EditCatalogoError());
      }
    }

    FutureOr<void> _takePicture(OnEditTakePictureEvent event, emit) async {
    emit(EditCatalogoLoadingState());
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
    emit(EditCatalogoLoadingState());
    bool _edited = await _saveEditFshare(event.dataToSaveEdit);

    var queryUser = await FirebaseFirestore.instance
          .collection("users")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");

    var docsRef = await queryUser.get();
    List<dynamic> listIds = docsRef.data()?["catalogueListId"] ?? [];

    var queryFotos = await FirebaseFirestore.instance
      .collection("catalogue")
      .get();

    var allMyFotosList = queryFotos.docs
      .where((element) => listIds.contains(element.id))
      .map((e) => e.data().cast<String, dynamic>()..addAll({"docId":e.id}))
      .toList();

    print(_edited);
    if(_edited){
      emit(EditCatalogoSuccessState());
      emit(EditCatalogoSuccess(EditData: allMyFotosList));
    } else {
      emit(EditCatalogoSuccess(EditData: allMyFotosList));
    }
  }

  Future<bool>_saveEditFshare(Map<String, dynamic> dataToSaveEdit) async {
    
    try{
      //Hacer el get de la coleccion de datos
      var docRef = await FirebaseFirestore.instance.collection("catalogue");
      
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
      .ref("catalogue/imagen_${stamp}.png")
      .putFile(_selectedPicture!);

      await task;

      String resultTask = await task.storage.ref("catalogue/imagen_${stamp}.png").getDownloadURL();

      return resultTask;

    }catch(e){
      return "";
    }
  }

  Future<void> _deleteItem(OnDeleteItemEvent event, Emitter emit) async {
    emit(EditCatalogoLoadingState());
    try{
        //ID of delete item
      String idDoc = event.id;

      // Get all items in user's array 
      var queryUser = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await queryUser.get();
      List<dynamic> catalogoListIds = docsRef.data()?["catalogueListId"];

      List<dynamic> newCatalogoListIds = [];

      // Remove item to delete from the array
      for(var id in catalogoListIds){
        if(id != idDoc){
          newCatalogoListIds.add(id);
        }
      }

      //Update new array to the user
      await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}")
        .update({"catalogueListId":newCatalogoListIds});

      //Delete the doc from catalogue collection
      await FirebaseFirestore.instance
        .collection("catalogue")
        .doc(idDoc)
        .delete();

      //Get the list again
      var queryFotos = await FirebaseFirestore.instance
      .collection("catalogue")
      .get();

    var allMyCatalogueList = queryFotos.docs
      .where((element) => newCatalogoListIds.contains(element.id))
      .map((e) => e.data().cast<String, dynamic>()..addAll({"docId":e.id}))
      .toList();

      emit(EditCatalogoSuccessState());
      emit(EditCatalogoSuccess(EditData: allMyCatalogueList));
    }catch(e){
      print("Error al borrar elemento: ${e}");
      emit(EditCatalogoError());
    }
    

  }

}
