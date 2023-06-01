// watch list of user orders if user signed in

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/orders/data/fake_orders_repository.dart';
import 'package:ecommerce_app/src/features/orders/domain/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products/domain/product.dart';

final userOrdersProvider = StreamProvider.autoDispose<List<Order>>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    final ordersRepository = ref.watch(ordersRepositoryProvider);
    return ordersRepository.watchUserOrders(user.uid);
  } else {
    // if user null,  return empty screen
    return Stream.value([]);
  }
});

// Check if a product was previously purchased by the user
final matchingUserOrderProvider = StreamProvider.family<List<Order>, ProductID>((
    ref, productId)  {
  final user = ref.watch(authStateChangesProvider).value;
if (user != null) {
  return ref.watch(ordersRepositoryProvider)
      .watchUserOrders(user.uid, productId: productId);
} else {
  // if the user is null, return an empty list (no orders)
  return Stream.value([]);
}
});
