import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_app_moviles/Pago/pago.dart';
import 'package:geolocator/geolocator.dart';

part 'pago_event.dart';
part 'pago_state.dart';

class PagoBloc extends Bloc<PagoEvent, PagoState> {
  PagoBloc() : super(PagoInitial()) {
    on<GetPagoEvent>(pagogego);
    on<AddPagoEvent>(pagogago);
    on<DeletePagoEvent>(pagodego);
    on<ClearPagoEvent>(clearPagos);
  }

  FutureOr<void> pagogego(event, emit) async{
    emit(PagoInitial());
    try{
      var queryUser = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await queryUser.get();
      List<dynamic> listIds = docsRef.data()?["shopListId"] ?? [];

      var queryFotos = await FirebaseFirestore.instance
        .collection("catalogue")
        .get();

      var allMyFotosList = queryFotos.docs
        .where((element) => listIds.contains(element.id))
        .map((e) => e.data().cast<String, dynamic>()..addAll({"docId":e.id}))
        .toList();

      emit(PagoSuccess(data: allMyFotosList));
    }catch(e){
      emit(PagoError("Error obteniendo los artículos del carrito de su cuenta."));
    }
  }

  FutureOr<void> pagogago(AddPagoEvent event, Emitter<PagoState> emit) async{
    emit(PagoInitial());
    try{
      var queryUser = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await queryUser.get();

      DocumentReference<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection("catalogue").doc(event.itemId);
      List<dynamic> carrito = docsRef.data()?["shopListId"];
      carrito.add(doc.id);
      await queryUser.update({"shopListId":carrito});

      emit(PagoSuccess(data: carrito as List<Map<String, dynamic>>));
    }catch(e){
      emit(PagoError("Error obteniendo los artículos del carrito de su cuenta."));
    }
  }

  FutureOr<void> pagodego(DeletePagoEvent event, Emitter<PagoState> emit) async{
    emit(PagoInitial());
    try{
      var queryUser = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await queryUser.get();
      List<dynamic> carritoListId = docsRef.data()?["shopListId"];

      List<dynamic> newCarrito = [];

      for(var itemCarrito in carritoListId){
        if(itemCarrito != event.itemId){
          newCarrito.add(itemCarrito);
        }
      }

      var qDeleteArray = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}")
        .update({"shopListId": newCarrito});

      var queryFotos = await FirebaseFirestore.instance
        .collection("catalogue")
        .get();

      var carritoList = queryFotos.docs
        .where((element) => newCarrito.contains(element.id))
        .map((e) => e.data().cast<String, dynamic>()..addAll({"docId":e.id}))
        .toList();

      emit(PagoEliminar());
      emit(PagoSuccess(data: carritoList));
    }catch(e){
      emit(PagoError("Error obteniendo los artículos del carrito de su cuenta."));
    }
  }

  FutureOr<void> clearPagos(ClearPagoEvent event, Emitter<PagoState> emit) async{
    emit(PagoInitial());
    try{
      var queryUser = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await queryUser.get();
      List<dynamic> listIds = docsRef.data()?["shopListId"];

      List<dynamic> carritoVacio = [];

      var qDeleteArray = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}")
        .update({"shopListId": carritoVacio});

      //Cambiar tipo de datos
      double total = double.parse(event.total);

      // print(event.data);
      // Elemento que sera insertado
      List<Map<String, dynamic>> shippingElements = [];
      for(var item in event.data){
        item.remove("docId");
        item.remove("public");
        item.remove("publishedAt");
        item.remove("picture");
        shippingElements.add(item);
      }

      Map<String, dynamic> newShippingItem = {
        "price": total,
        "location": GeoPoint(event.ubicacion.latitude, event.ubicacion.longitude),
        "shipElements": shippingElements,
        "buyer": FirebaseAuth.instance.currentUser!.uid,
      };

      //Agregar el doc en la nueva coleccion
      var newDocRefs = await FirebaseFirestore.instance
        .collection("shippings")
        .add(newShippingItem);

      //Actualizar el arreglo del usuario
      var shippingQueryUser = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");
      
      var userDocRefs = await shippingQueryUser.get();
      List<dynamic> shipListIds = userDocRefs.data()?["shippingListId"];

      //Agregar el id del elemento nuevo
      shipListIds.add(newDocRefs.id);

      //Actualizar el arreglo del usuario
      await shippingQueryUser.update({"shippingListId": shipListIds});
      emit(PagoSuccess(data: []));
    }catch(e){
      emit(PagoError("Error obteniendo los artículos del carrito de su cuenta."));
    }
  }
}
