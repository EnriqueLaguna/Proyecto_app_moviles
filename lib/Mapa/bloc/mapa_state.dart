part of 'mapa_bloc.dart';

abstract class MapaState extends Equatable {
  const MapaState();
  
  @override
  List<Object> get props => [];
}

class MapaInitial extends MapaState {}
class MapaSuccess extends MapaState {}
class MapaError extends MapaState {}
