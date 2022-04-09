part of 'editcatalogo_bloc.dart';

abstract class EditcatalogoEvent extends Equatable {
  const EditcatalogoEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyDataEvent extends EditcatalogoEvent{}

class OnClickEditarButtonEvent extends EditcatalogoEvent{
  final String dataToEdit;

  OnClickEditarButtonEvent({required this.dataToEdit});

  @override
  List<Object> get props => [dataToEdit];
}

class OnEditTakePictureEvent extends EditcatalogoEvent{}

class OnEditSaveDataEvent extends EditcatalogoEvent{
  final Map<String, dynamic> dataToSaveEdit;

  OnEditSaveDataEvent({required this.dataToSaveEdit});

  @override
  List<Object> get props => [dataToSaveEdit];
}