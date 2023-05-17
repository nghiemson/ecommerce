import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

/// Helper extension used to mutate the items in the shopping cart.
extension MutableCart on Cart {
  // add an item to cart by overriding the quantity if it already exists
  Cart setItem(Item item) {
    final copy = Map<ProductID, int>.from(items);
    copy[item.productId] = item.quantity;
    return Cart(copy);
  }

  // add an item to cart by updating the quantity if it already exists
  Cart addItem(Item item) {
    final copy = Map<ProductID, int>.from(items);
    copy.update(
      item.productId,
      //if there's already a value, update it by adding the item quantity
      (value) => item.quantity + value,
      //else add the item with the given quantity
      ifAbsent: () => item.quantity,
    );
    return Cart(copy);
  }

  Cart addItems(List<Item> itemsToAdd) {
    final copy = Map<ProductID, int>.from(items);
    for (var item in itemsToAdd) {
      copy.update(
        item.productId,
        (value) => item.quantity + value,
        ifAbsent: () => item.quantity,
      );
    }
    return Cart(copy);
  }

  Cart removeItemById(ProductID productId) {
    final copy = Map<ProductID, int>.from(items);
    copy.remove(productId);
    return Cart(copy);
  }


  Cart clear() {
    return const Cart();
  }
}
