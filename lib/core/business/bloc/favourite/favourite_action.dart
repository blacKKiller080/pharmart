import '../../models/product.dart';

class FavouriteAction {
  final _items = <Product>[];

  void addItemToFavourite(Product product) => _items.add(product);

  void removeItemFromFavourite(Product product) => _items.remove(product);
}
