import '../../models/product.dart';

class CardAction {
  final _items = <Product>[];

  void addItemToCard(Product product) => _items.add(product);

  void removeItemFromCard(Product product) => _items.remove(product);
}
