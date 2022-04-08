part of 'create_catalogo_bloc.dart';

abstract class CreateCatalogoState extends Equatable {
  const CreateCatalogoState();
  
  @override
  List<Object> get props => [];
}

class CreateCatalogoInitial extends CreateCatalogoState {}

class CreateSuccessState extends CreateCatalogoState {}

class CreateCatalogoErrorState extends CreateCatalogoState {}

class CreateLoadingState extends CreateCatalogoState {}

class CreatePictureErrorState extends CreateCatalogoState {}

class CreatePictureChangedState extends CreateCatalogoState {
  final File picture;

  CreatePictureChangedState({required this.picture});

  @override
  List<Object> get props => [picture];
}