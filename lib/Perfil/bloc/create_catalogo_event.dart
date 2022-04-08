part of 'create_catalogo_bloc.dart';

abstract class CreateCatalogoEvent extends Equatable {
  const CreateCatalogoEvent();

  @override
  List<Object> get props => [];
}

class OnCreateTakePictureEvent extends CreateCatalogoEvent{}

class OnCreateSaveDataEvent extends CreateCatalogoEvent{
  final Map<String, dynamic> dataToSave;

  OnCreateSaveDataEvent({required this.dataToSave});

  @override
  List<Object> get props => [dataToSave];
}