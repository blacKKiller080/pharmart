import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/card.dart';
import '../../models/product.dart';
import 'cart_action.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardAction cardAction;

  CardBloc(this.cardAction) : super(CardInitial()) {
    on<GetCardEvent>((event, emit) {
      emit(CardLoading());
      emit(const CardLoaded());
    });
    on<AddItemCard>((event, emit) {
      final state = this.state;
      if (state is CardLoaded) {
        cardAction.addItemToCard(event.product);
        try {
          emit(CardLoaded(
              card: Card(items: [...state.card.items, event.product])));
        } catch (e) {
          emit(CardError());
        }
      }
    });
    on<RemoveItemCard>((event, emit) {
      final state = this.state;
      if (state is CardLoaded) {
        cardAction.removeItemFromCard(event.product);
        try {
          emit(CardLoaded(
              card: Card(items: [...state.card.items]..remove(event.product))));
        } catch (e) {
          emit(CardError());
        }
      }
    });
  }
}
