import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:proyecto_app_moviles/Catalogo/bloc/catalogo_bloc.dart';

part 'cuidados_event.dart';
part 'cuidados_state.dart';

class CuidadosBloc extends Bloc<CuidadosEvent, CuidadosState> {
  CuidadosBloc() : super(CuidadosInitial()) {
    on<CuidadosGetEvent>(getCuidados);
  }

  FutureOr<void> getCuidados(event, emit) async{
    try {
      var allDocs = await FirebaseFirestore.instance.collection("tips").get();
     List<Map<String, dynamic>> data = allDocs.docs.where((doc) => doc["public"]).map((e) => e.data()..addAll({"docId": e.id})).toList();;
      print(data);
      emit(CuidadosSuccess(data: data));
    } catch (e) {
      emit(CuidadosError());
    }
  }
}