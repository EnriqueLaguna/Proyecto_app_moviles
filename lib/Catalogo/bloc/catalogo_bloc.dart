import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'catalogo_event.dart';
part 'catalogo_state.dart';

class CatalogoBloc extends Bloc<CatalogoEvent, CatalogoState> {
  CatalogoBloc() : super(CatalogoInitial()) {
    on<CatalogoEvent>(getCatalog);
  }

  FutureOr<void> getCatalog(event, emit) async{
    try {
      var allDocs = await FirebaseFirestore.instance.collection("catalogue").get();
      List<Map<String, dynamic>> data = allDocs.docs.where((doc) => doc["public"]).map((e) => e.data()..addAll({"docId": e.id})).toList();
      emit(CatalogoSuccess(data: data));
    } catch (e) {
      emit(CatalogoError());
    }
  }
}
