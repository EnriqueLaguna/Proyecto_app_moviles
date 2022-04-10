part of 'editcuidados_bloc.dart';

abstract class EditcuidadosState extends Equatable {
  const EditcuidadosState();

  @override
  List<Object> get props => [];
}

class EditcuidadosInitial extends EditcuidadosState {}
class EditCuidadosSuccess extends EditcuidadosState {
  final List<Map<String, dynamic>> EditData;

  EditCuidadosSuccess({required this.EditData});

  @override
  List<Object> get props => this.EditData;
}
class EditCuidadosError extends EditcuidadosState {}

class EditFotosEditState extends EditcuidadosState{
  final File picture;

  EditFotosEditState({required this.picture});

  @override
  List<Object> get props => [picture];

}

class EditFotoErrorState extends EditcuidadosState{}

class EditCuidadosLoadingState extends EditcuidadosState{}

class EditCuidadosSuccessState extends EditcuidadosState{}

class EditErrorState extends EditcuidadosState{} 