import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeProductsRepository makeProductsRepository() =>
      FakeProductsRepository(addDelay: false);
  group('Fake Repo test', () {
    test('getListProduct', () {
      final productRepo = makeProductsRepository();
      expect(productRepo.getProductsList(), kTestProducts);
    });

    test('getProduct(1)', () {
      final productRepo = makeProductsRepository();
      expect(productRepo.getProduct('1'), kTestProducts[0]);
    });

    test('getProduct(100)', () {
      final productRepo = makeProductsRepository();
      expect(productRepo.getProduct('100'), null);
    });
  });

  test('fetchProductList returns global list', () async {
    final productsRepo = makeProductsRepository();
    expect(await productsRepo.fetchProductList(), kTestProducts);
  });

  test('watchProductList emits global list', () {
    final productsRepo = makeProductsRepository();
    expect(productsRepo.watchProductList(), emits(kTestProducts));
  });

  test('watchProduct(1) emits 1st item', () {
    final productsRepo = makeProductsRepository();
    expect(productsRepo.watchProduct('1'), emits(kTestProducts[0]));
  });

  test('watchProduct(100) emits null', () {
    final productsRepo = makeProductsRepository();
    expect(productsRepo.watchProduct('100'), emits(null));
  });
}
