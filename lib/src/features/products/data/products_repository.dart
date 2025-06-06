import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/product.dart';

part 'products_repository.g.dart';

class ProductsRepository {
  const ProductsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static String productsPath() => 'products';

  static String productPath(ProductID id) => 'products/$id';

  // TODO: Implement all methods using Cloud Firestore
  Future<List<Product>> fetchProductList() async {
    final ref = _productsRef();
    return await ref
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Product>> watchProductList() {
    final ref = _productsRef();
    return ref
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<Product?> watchProduct(ProductID id) {
    final ref = _productRef(id);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  Future<List<Product>> searchProducts(String query) {
    return Future.value([]);
  }

  Future<void> createProduct(ProductID id, String imageUrl) {
    return _firestore.doc(productPath(id)).set(
      {
        'id': id,
        'imageUrl': imageUrl,
      },
      SetOptions(merge: true),
    );
  }

  DocumentReference<Product> _productRef(ProductID id) {
    return _firestore.doc(productPath(id)).withConverter(
          fromFirestore: (doc, _) => Product.fromMap(doc.data()!),
          toFirestore: (product, _) => product.toMap(),
        );
  }

  Query<Product> _productsRef() {
    return _firestore.collection(productsPath()).withConverter(
          fromFirestore: (doc, _) => Product.fromMap(doc.data()!),
          toFirestore: (product, _) => product.toMap(),
        );
  }
}

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(Ref ref) {
  return ProductsRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Product>> productsListStream(Ref ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductList();
}

@riverpod
Future<List<Product>> productsListFuture(Ref ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductList();
}

@riverpod
Stream<Product?> product(Ref ref, ProductID id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
}

@riverpod
Future<List<Product>> productsListSearch(Ref ref, String query) async {
  final link = ref.keepAlive();
  // a timer to be used by the callbacks below
  Timer? timer;
  // When the provider is destroyed, cancel the http request and the timer
  ref.onDispose(() {
    timer?.cancel();
  });
  // When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
    // start a 30 second timer
    timer = Timer(const Duration(seconds: 30), () {
      // dispose on timeout
      link.close();
    });
  });
  // If the provider is listened again after it was paused, cancel the timer
  ref.onResume(() {
    timer?.cancel();
  });
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.searchProducts(query);
}
