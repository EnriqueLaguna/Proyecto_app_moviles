part of 'editcatalogo_bloc.dart';

abstract class EditcatalogoState extends Equatable {
  const EditcatalogoState();
  
  @override
  List<Object> get props => [];
}

class EditcatalogoInitial extends EditcatalogoState {}
class EditCatalogoSuccess extends EditcatalogoState {
  final List<Map<String, dynamic>> EditData;

  EditCatalogoSuccess({required this.EditData});

  @override
  List<Object> get props => this.EditData;
}
class EditCatalogoError extends EditcatalogoState {}

class EditFotosEditState extends EditcatalogoState{
  final File picture;

  EditFotosEditState({required this.picture});

  @override
  List<Object> get props => [picture];
  
}

class EditFotoErrorState extends EditcatalogoState{}

class EditCatalogoLoadingState extends EditcatalogoState{}

class EditCatalogoSuccessState extends EditcatalogoState{}

class EditErrorState extends EditcatalogoState{}