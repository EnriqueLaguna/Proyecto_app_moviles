part of 'pago_bloc.dart';

abstract class PagoEvent extends Equatable {
  const PagoEvent();

  @override
  List<Object> get props => [];
}

class GetPagoEvent extends PagoEvent{}
class AddPagoEvent extends PagoEvent{
  final String itemId;

  AddPagoEvent({required this.itemId});
  @override
  List<Object> get props => [this.itemId];
}
class DeletePagoEvent extends PagoEvent{
  final String itemId;

  DeletePagoEvent({required this.itemId});
  @override
  List<Object> get props => [this.itemId];
}
class ClearPagoEvent extends PagoEvent{
  final double total;
  ClearPagoEvent({required this.total});
  @override
  List<Object> get props => [this.total];
}
