part of 'pago_bloc.dart';

abstract class PagoState extends Equatable {
  const PagoState();
  
  @override
  List<Object> get props => [];
}

class PagoInitial extends PagoState {}

class PagoSuccess extends PagoState {
  final List<Map<String, dynamic>> data;

  PagoSuccess({required this.data});
  @override
  List<Object> get props => this.data;
}
class PagoError extends PagoState {
  final String msg;

  PagoError(this.msg);
  @override
  List<Object> get props => [this.msg];
}
