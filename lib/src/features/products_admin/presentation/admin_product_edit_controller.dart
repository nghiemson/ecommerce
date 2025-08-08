import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/notifier_mounted.dart';
import '../../products/domain/product.dart';
import '../application/image_upload_service.dart';

part 'admin_product_edit_controller.g.dart';

@riverpod
class AdminProductEditController extends _$AdminProductEditController with NotifierMounted {
  @override
  FutureOr<void> build() async {
    ref.onDispose(setUnmounted);
  }

  Future<bool> updateProduct({
    required Product product,
    required String title,
    required String description,
    required String price,
    required String availableQuantity,
  }) async {
    final productRepository = ref.read(productsRepositoryProvider);
    final updateProduct = product.copyWith(
      title: title,
      description: description,
      price: double.parse(price),
      availableQuantity: int.parse(availableQuantity),
    );
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => productRepository.updateProduct(updateProduct),
    );
    final success = state.hasError == false;
    if (success) {
      ref.read(goRouterProvider).pop();
    }
    return success;
  }

  Future<void> deleteProduct(Product product) async {
    final imageUploadService = ref.read(imageUploadServiceProvider);
    state = const AsyncLoading();
    final value = await AsyncValue.guard(
      () => imageUploadService.deleteProduct(product),
    );
    final success = value.hasError == false;
    if (mounted) {
      state = value;
      if (success) {
        ref.read(goRouterProvider).pop();
      }
    }
  }
}
