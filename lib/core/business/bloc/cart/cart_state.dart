part of 'cart_bloc.dart';

abstract class CardState extends Equatable {
  const CardState();
}

class CardInitial extends CardState {
  @override
  List<Object> get props => [];
}

class CardLoading extends CardState {
  @override
  List<Object> get props => [];
}

class CardLoaded extends CardState {
  final Card card;

  const CardLoaded({this.card = const Card()});

  @override
  List<Card> get props => [card];
}

class CardError extends CardState {
  @override
  List<Object> get props => [];
}
