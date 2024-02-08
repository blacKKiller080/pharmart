part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();
}

class FavouriteInitial extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteAwait extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteItems extends FavouriteState {
  final Favourite favourite;

  const FavouriteItems({this.favourite = const Favourite()});

  @override
  List<Favourite> get props => [favourite];
}

class FavouriteError extends FavouriteState {
  @override
  List<Object> get props => [];
}
