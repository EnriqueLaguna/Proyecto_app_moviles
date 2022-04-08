part of 'catalogo_bloc.dart';

abstract class CatalogoState extends Equatable {
  const CatalogoState();
  
  @override
  List<Object> get props => [];
}

class CatalogoInitial extends CatalogoState {}
class CatalogoSuccess extends CatalogoState {
  final List<Map<String, dynamic>> data;

  CatalogoSuccess({required this.data});

  @override
  List<Object> get props => this.data;
}
class CatalogoError extends CatalogoState {}
