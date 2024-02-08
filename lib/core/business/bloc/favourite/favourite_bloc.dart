import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/favourite.dart';
import '../../models/product.dart';
import 'favourite_action.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteAction favouriteAction;

  FavouriteBloc(this.favouriteAction) : super(FavouriteInitial()) {
    on<FavouriteStarted>((event, emit) {
      emit(FavouriteAwait());
      emit(const FavouriteItems());
    });
    on<AddItemFavourite>((event, emit) {
      final state = this.state;
      if (state is FavouriteItems) {
        favouriteAction.addItemToFavourite(event.product);
        try {
          emit(FavouriteItems(
              favourite:
                  Favourite(items: [...state.favourite.items, event.product])));
        } catch (e) {
          emit(FavouriteError());
        }
      }
    });
    on<RemoveItemFavourite>((event, emit) {
      final state = this.state;
      if (state is FavouriteItems) {
        favouriteAction.removeItemFromFavourite(event.product);
        try {
          emit(FavouriteItems(
              favourite: Favourite(
                  items: [...state.favourite.items]..remove(event.product))));
        } catch (e) {
          emit(FavouriteError());
        }
      }
    });
  }
}
