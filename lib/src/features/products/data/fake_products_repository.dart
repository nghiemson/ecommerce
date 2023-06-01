import 'dart:async';

import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  FakeProductsRepository({this.addDelay = true});

  final bool addDelay;

  final _products = InMemoryStore<List<Product>>(List.from(kTestProducts));

  List<Product> getProductsList() {
    return _products.value;
  }

  Product? getProduct(String id) {
    return _getProduct(_products.value, id);
  }

  Future<List<Product>> fetchProductList() async {
    await delay(addDelay);
    return Future.value(_products.value);
  }

  Stream<List<Product>> watchProductsList() {
    return _products.stream;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList().map((products) => _getProduct(products, id));
  }

  /// update product rating
  Future<void> updateProductRating({
    required ProductID productId,
    required double avgRating,
    required int numRatings,
  }) async {
    await delay(addDelay);
    final products = _products.value;
    final index = products.indexWhere((element) => element.id == productId);
    if (index == -1) {
      throw StateError('Product not found (id: $productId)'.hardcoded);
    }
    products[index] = products[index].copyWith(
      avgRating: avgRating,
      numRatings: numRatings,
    );
    _products.value = products;
  }

  Future<List<Product>> searchProducts(String query) async {
    // get all products
    final productsList = await fetchProductList();
    // match all products where the title contains the query
    return productsList
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static Product? _getProduct(List<Product> products, String id) {
    try {
      return products.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((_) {
  return FakeProductsRepository(addDelay: false);
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final productsRepo = ref.watch(productsRepositoryProvider);
  return productsRepo.watchProductsList();
});

final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final productsRepo = ref.watch(productsRepositoryProvider);
  return productsRepo.fetchProductList();
});

final productProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  final productsRepo = ref.watch(productsRepositoryProvider);
  return productsRepo.watchProduct(id);
});

final productsListSearchProvider = FutureProvider.autoDispose
    .family<List<Product>, String>((ref, query) async {
      final link = ref.keepAlive();
      Timer(const Duration(seconds: 5), () {
        link.close();
      });
      // debounce/delay network request
      //only works in combination with a CancelToken
      await Future.delayed(const Duration(milliseconds: 500));
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.searchProducts(query);
});
