import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  final List<Product> _product = kTestProducts;

  List<Product> getProductsList() {
    return _product;
  }

  Product? getProduct(String id) =>
      _product.firstWhere((element) => element.id == id);

  Future<List<Product>> fetchProductList() async {
    await Future.delayed(const Duration(seconds: 3));
    return Future.value(_product);
  }

  Stream<List<Product>> watchProductsList() async* {
    yield _product;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((element) => element.id == id));
  }
}

final productsRepoProvider = Provider<FakeProductsRepository>((_) {
  return FakeProductsRepository();
});

final productsListStreamProvider = StreamProvider<List<Product>>((ref) {
  final productsRepo = ref.watch(productsRepoProvider);
  return productsRepo.watchProductsList();
});

final productsListFutureProvider = FutureProvider<List<Product>>((ref) {
  final productsRepo = ref.watch(productsRepoProvider);
  return productsRepo.fetchProductList();
});
