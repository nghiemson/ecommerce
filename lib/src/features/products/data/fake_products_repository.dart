import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

class FakeProductsRepository {
  FakeProductsRepository._();

  final List<Product> _product = kTestProducts;
  static FakeProductsRepository instance = FakeProductsRepository._();
  List<Product> getProductsList() {
    return _product;
  }

  Product? getProduct(String id) =>
      _product.firstWhere((element) => element.id == id);

  Future<List<Product>> fetchProductList() {
    return Future.value(_product);
  }

  Stream<List<Product>> watchProductsList() {
    return Stream.value(_product);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((element) => element.id == id));
  }
}
