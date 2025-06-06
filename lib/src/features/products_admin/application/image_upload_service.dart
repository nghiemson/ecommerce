import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/products_admin/data/image_upload_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../products/data/products_repository.dart';
part 'image_upload_service.g.dart';

class ImageUploadService {
  const ImageUploadService(this.ref);

  final Ref ref;

  Future<void> uploadProduct(Product product) async {
    final downloadUrl = await ref
        .read(imageUploadRepositoryProvider)
        .uploadProductImageFromAsset(product.imageUrl, product.id);
    await ref
        .read(productsRepositoryProvider)
        .createProduct(product.id, downloadUrl);
  }
}

@riverpod
ImageUploadService imageUploadService(Ref ref) {
  return ImageUploadService(ref);
}
