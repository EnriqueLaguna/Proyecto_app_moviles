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

class OnEditTakePictureEvent extends EditcatalogoEvent{
  final bool isCamera;

  OnEditTakePictureEvent({required this.isCamera});
  @override
  List<Object> get props => [this.isCamera];
}

class OnEditSaveDataEvent extends EditcatalogoEvent{
  final Map<String, dynamic> dataToSaveEdit;

  OnEditSaveDataEvent({required this.dataToSaveEdit});

  @override
  List<Object> get props => [dataToSaveEdit];
}

class OnDeleteItemEvent extends EditcatalogoEvent{
  final String id;
  OnDeleteItemEvent({required this.id});
  @override
  List<Object> get props => [id];
}