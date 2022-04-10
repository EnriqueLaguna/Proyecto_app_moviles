part of 'create_cuidados_bloc.dart';

abstract class CreateCuidadosState extends Equatable {
  const CreateCuidadosState();

  @override
  List<Object> get props => [];
}

class CreateCuidadosInitial extends CreateCuidadosState {}

class CreateSuccessState extends CreateCuidadosState {}

class CreateCuidadosErrorState extends CreateCuidadosState {}

class CreateLoadingState extends CreateCuidadosState {}

class CreatePictureErrorState extends CreateCuidadosState {}

class CreatePictureChangedState extends CreateCuidadosState {
  final File picture;

  CreatePictureChangedState({required this.picture});

  @override
  List<Object> get props => [picture];
}