import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaInitial()) {
    on<DeletePedidoEvent>(deletePedido);
  }

  FutureOr<void> deletePedido(DeletePedidoEvent event, emit) async{
    emit(MapaInitial());
    try{
      var queryUser = await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

      var docsRef = await queryUser.get();
      List<dynamic> pedidoListId = docsRef.data()?["shippingListId"];

      List<dynamic> newPedidos = [];

      for(var itemCarrito in pedidoListId){
        if(itemCarrito != event.itemId){
          newPedidos.add(itemCarrito);
        }
      }

      await FirebaseFirestore.instance
        .collection("users")
        .doc("${FirebaseAuth.instance.currentUser!.uid}")
        .update({"shippingListId": newPedidos});

      await FirebaseFirestore.instance.collection("shippings").doc(event.itemId).delete();

      emit(MapaSuccess());
    }catch(e){
      emit(MapaError());
    }
  }
}
