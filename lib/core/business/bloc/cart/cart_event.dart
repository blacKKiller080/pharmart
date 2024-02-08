part of 'cart_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();
}

class GetCardEvent extends CardEvent {
  @override
  List<String> get props => [];
}

class AddItemCard extends CardEvent {
  final Product product;

  const AddItemCard(this.product);

  @override
  List<Product> get props => [product];
}

class RemoveItemCard extends CardEvent {
  final Product product;

  const RemoveItemCard(this.product);

  @override
  List<Product> get props => [product];
}
