part of 'catalogo_bloc.dart';

abstract class CatalogoEvent extends Equatable {
  const CatalogoEvent();

  @override
  List<Object> get props => [];
}

class CatalogoGetEvent extends CatalogoEvent {}
