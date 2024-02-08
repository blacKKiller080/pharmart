import 'package:equatable/equatable.dart';
import 'package:pharma/core/business/models/product.dart';

class Card extends Equatable {
  const Card({this.items = const <Product>[]});

  final List<Product> items;

  @override
  List<List<Product>> get props => [items];
}
