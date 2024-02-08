import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../provider/authorization/authorization_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:pharma/core/business/models/category_dto.dart';
part 'category_event.dart';
part 'category_State.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  void getCategory(String lang) => add(GetCategoryEvent(lang));
  final AuthorizationProvider _provider;
  CategoryBloc(this._provider) : super(CategoryStateLoading()) {
    on<GetCategoryEvent>(
      (event, emit) async {
        emit(CategoryStateLoading());
        try {
          final mList = await _provider.getCategory(event.lang);
          emit(CategoryStateLoaded(mList.category_dto!));
        } catch (e) {
          debugPrint('CategoryEvent error: $e');
          emit(CategoryStateError(e.toString()));
        }
      },
    );
  }
}
