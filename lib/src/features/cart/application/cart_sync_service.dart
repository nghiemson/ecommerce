import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/mutable_cart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartSyncService {
  CartSyncService(this.ref) {
    _init();
  }
  final Ref ref;

  void _init() {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) {
      final previousUser = previous?.value;
      final user = next.value;
      if (previousUser == null && user != null) {
        _moveItemToRemoteCart(user.uid);
      }
    });
  }

  // move all item from local to remote cart
  Future<void> _moveItemToRemoteCart(String uid) async {
    // Get the local cart data
    final localCartRepository = ref.read(localCartRepositoryProvider);
    final localCart = await localCartRepository.fetchCart();
    if (localCart.items.isNotEmpty) {
      // Get the remote cart data
      final remoteCartRepository = ref.read(remoteCartRepositoryProvider);
      final remoteCart = await remoteCartRepository.fetchCart(uid);
      final localItemsToAdd = localCart.toItemsList();
      // Add all local items to remote cart
      final updatedRemoteCart = remoteCart.addItems(localItemsToAdd);
      // Write the updated remote cart data to the repository
      await remoteCartRepository.setCart(uid, updatedRemoteCart);
      // Remote all items from local cart
      await localCartRepository.setCart(const Cart());
    }
  }
}

final cartSyncServiceProvider = Provider<CartSyncService>((ref) {
  return CartSyncService(ref);
});
