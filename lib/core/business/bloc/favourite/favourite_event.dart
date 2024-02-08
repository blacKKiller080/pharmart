part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();
}

class FavouriteStarted extends FavouriteEvent {
  @override
  List<String> get props => [];
}

class AddItemFavourite extends FavouriteEvent {
  final Product product;

  const AddItemFavourite(this.product);

  @override
  List<Product> get props => [product];
}

class RemoveItemFavourite extends FavouriteEvent {
  final Product product;

  const RemoveItemFavourite(this.product);

  @override
  List<Product> get props => [product];
}
