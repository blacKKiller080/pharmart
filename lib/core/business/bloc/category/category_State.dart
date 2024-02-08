part of 'category_bloc.dart';

@immutable
abstract class CategoryState {
  const CategoryState();
}

class CategoryStateInitial extends CategoryState {}

class CategoryStateLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryStateLoaded extends CategoryState {
  const CategoryStateLoaded(this.category_dto);
  final List<CategoryDto>? category_dto;
}

class CategoryStateError extends CategoryState {
  final String? message;
  const CategoryStateError(this.message);
}
