part of 'editcuidados_bloc.dart';

abstract class EditcuidadosEvent extends Equatable {
  const EditcuidadosEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyDataEventCuidados extends EditcuidadosEvent{}

class OnClickEditarButtonEvent extends EditcuidadosEvent{
  final String dataToEdit;

  OnClickEditarButtonEvent({required this.dataToEdit});

  @override
  List<Object> get props => [dataToEdit];
}

class OnEditTakePictureEvent extends EditcuidadosEvent{
  final bool isCamera;

  OnEditTakePictureEvent({required this.isCamera});
  @override
  List<Object> get props => [this.isCamera];
}

class OnEditSaveDataEvent extends EditcuidadosEvent{
  final Map<String, dynamic> dataToSaveEdit;

  OnEditSaveDataEvent({required this.dataToSaveEdit});

  @override
  List<Object> get props => [dataToSaveEdit];
}