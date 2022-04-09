part of 'cuidados_bloc.dart';

abstract class CuidadosEvent extends Equatable {
  const CuidadosEvent();

  @override
  List<Object> get props => [];
}

class CuidadosGetEvent extends CuidadosEvent {}
