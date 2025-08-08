import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../products/data/fake_products_repository.dart' hide productsRepositoryProvider;
import '../../products/data/products_repository.dart';
import '../../products/domain/product.dart';

part 'template_products_provider.g.dart';

@riverpod
ProductsRepository templateProductsRepository(Ref ref) {
  return FakeProductsRepository(addDelay: false);
}

@riverpod
Stream<List<Product>> templateProductsList(Ref ref) {
  final templateProductStream =
      ref.watch(templateProductsRepositoryProvider).watchProductList();
  final existingProductStream = ref.watch(productsRepositoryProvider).watchProductList();
  return Rx.combineLatest2(templateProductStream, existingProductStream, (template, existing) {
    final existingIds = existing.map((product) => product.id).toList();
    return template.where((product) => !existingIds.contains(product.id)).toList();
  });
}

@riverpod
Stream<Product?> templateProduct(Ref ref, ProductID id) {
  return ref.watch(templateProductsRepositoryProvider).watchProduct(id);
}
