import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  final bool addDelay;
  final List<Product> _product = kTestProducts;

  List<Product> getProductsList() {
    return _product;
  }

  Product? getProduct(String id) {
    return _getProduct(_product, id);
  }

  Future<List<Product>> fetchProductList() async {
    await delay(addDelay);
    return Future.value(_product);
  }

  Stream<List<Product>> watchProductsList() async* {
    await delay(addDelay);
    yield _product;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList().map((products) => _getProduct(products, id));
  }

  static Product? _getProduct(List<Product> products, String id) {
    try {
      return products.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }

  FakeProductsRepository({this.addDelay = true});
}

final productsRepoProvider = Provider<FakeProductsRepository>((_) {
  return FakeProductsRepository();
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final productsRepo = ref.watch(productsRepoProvider);
  return productsRepo.watchProductsList();
});

final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final productsRepo = ref.watch(productsRepoProvider);
  return productsRepo.fetchProductList();
});

final productProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  final productsRepo = ref.watch(productsRepoProvider);
  return productsRepo.watchProduct(id);
});
