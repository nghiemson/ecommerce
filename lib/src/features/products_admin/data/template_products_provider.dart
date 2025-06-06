import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../products/data/fake_products_repository.dart';
import '../../products/data/products_repository.dart';
import '../../products/domain/product.dart';

part 'template_products_provider.g.dart';

@riverpod
ProductsRepository templateProductsRepository(Ref ref) {
  return FakeProductsRepository(addDelay: false);
}

@riverpod
Stream<List<Product>> templateProductsList(Ref ref) {
  return ref.watch(templateProductsRepositoryProvider).watchProductList();
}

@riverpod
Stream<Product?> templateProduct(Ref ref, ProductID id) {
  return ref.watch(templateProductsRepositoryProvider).watchProduct(id);
}