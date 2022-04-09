part of 'cuidados_bloc.dart';

abstract class CuidadosState extends Equatable {
  const CuidadosState();
  
  @override
  List<Object> get props => [];
}

class CuidadosInitial extends CuidadosState {}
class CuidadosSuccess extends CuidadosState {
  final List<Map<String, dynamic>> data;

  CuidadosSuccess({required this.data});

  @override
  List<Object> get props => this.data;
}

class CuidadosError extends CatalogoState {}