part of 'create_cuidados_bloc.dart';

abstract class CreateCuidadosEvent extends Equatable {
  const CreateCuidadosEvent();

  @override
  List<Object> get props => [];
}

class OnCreateTakePictureEvent extends CreateCuidadosEvent{}

class OnCreateSaveDataEvent extends CreateCuidadosEvent{
  final Map<String, dynamic> dataToSave;

  OnCreateSaveDataEvent({required this.dataToSave});

  @override
  List<Object> get props => [dataToSave];
}