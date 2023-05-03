import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Fake Repo test', () {
    test('getListProduct', () {
      final productRepo = FakeProductsRepository();
      expect(productRepo.getProductsList(), kTestProducts);
    });

    test('getProduct(1)', () {
      final productRepo = FakeProductsRepository();
      expect(productRepo.getProduct('1'), kTestProducts[0]);
    });

    test('getProduct(100)', () {
      final productRepo = FakeProductsRepository();
      expect(productRepo.getProduct('100'), null);
    });
  });

  test('fetchProductList returns global list', () async {
    final productsRepo = FakeProductsRepository();
    expect(await productsRepo.fetchProductList(), kTestProducts);
  });

  test('watchProductList emits global list', () {
    final productsRepo = FakeProductsRepository();
    expect(productsRepo.watchProductsList(), emits(kTestProducts));
  });

  test('watchProduct(1) emits 1st item', () {
    final productsRepo = FakeProductsRepository();
    expect(productsRepo.watchProduct('1'), emits(kTestProducts[0]));
  });

  test('watchProduct(100) emits null', () {
    final productsRepo = FakeProductsRepository();
    expect(productsRepo.watchProduct('100'), emits(null));
  });
}
