part of 'mapa_bloc.dart';

abstract class MapaEvent extends Equatable {
  const MapaEvent();

  @override
  List<Object> get props => [];
}
class DeletePedidoEvent extends MapaEvent{
  final String itemId;

  DeletePedidoEvent({required this.itemId});
  @override
  List<Object> get props => [this.itemId];
}
