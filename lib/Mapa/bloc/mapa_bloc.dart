import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaInitial()) {
    on<MapaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
