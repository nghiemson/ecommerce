import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:ecommerce_app/src/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../products/domain/product.dart';
import '../application/image_upload_service.dart';

part 'admin_product_upload_controller.g.dart';

@riverpod
class AdminProductUploadController extends _$AdminProductUploadController with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
  }

  Future<void> upload(Product product) async {
    try {
      state = const AsyncLoading();
      await ref.read(imageUploadServiceProvider).uploadProduct(product);
      ref.read(goRouterProvider).goNamed(AppRoute.adminEditProduct.name,
          pathParameters: {'id': product.id});
    } catch (e, st) {
      if (mounted) {
        state = AsyncError(e, st);
      }
    }
  }
}
