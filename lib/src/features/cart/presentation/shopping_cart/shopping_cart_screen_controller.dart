import 'package:ecommerce_app/src/features/cart/application/cart_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../products/domain/product.dart';
import '../../domain/item.dart';

class ShoppingCartScreenController extends StateNotifier<AsyncValue<void>> {
  ShoppingCartScreenController({required this.cartService})
      : super(const AsyncData(null));
  final CartService cartService;

  Future<void> updateItemQuantity(ProductID id, int quantity) async {
    state = const AsyncLoading();
    final updated = Item(productId: id, quantity: quantity);
    state = await AsyncValue.guard(() => cartService.setItem(updated));
  }

  Future<void> removeItemById(ProductID id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => cartService.removeItemById(id));
  }
}

final shoppingCartScreenControllerProvider =
    StateNotifierProvider<ShoppingCartScreenController, AsyncValue<void>>(
        (ref) {
  return ShoppingCartScreenController(
      cartService: ref.watch(cartServiceProvider));
});
