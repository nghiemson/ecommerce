import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../products/domain/product.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'image_upload_repository.g.dart';

/// Class for uploading images to Firebase Storage
class ImageUploadRepository {
  ImageUploadRepository(this._storage);

  final FirebaseStorage _storage;

  /// Upload an image asset to Firebase Storage and returns the download URL
  Future<String> uploadProductImageFromAsset(
      String assetPath, ProductID productId) async {
    final asset = await rootBundle.load(assetPath);
    final filename = assetPath.split('/')[2];
    final result = await _uploadAsset(asset, filename);
    return result.ref.getDownloadURL();
  }

  UploadTask _uploadAsset(ByteData byteData, String filename) {
    final bytes = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    final ref = _storage.ref('products/$filename');
    return ref.putData(
      bytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );
  }

  Future<void> deleteProductImage(String imageUrl) =>
      _storage.refFromURL(imageUrl).delete();
}

@riverpod
ImageUploadRepository imageUploadRepository(Ref ref) {
  return ImageUploadRepository(FirebaseStorage.instance);
}
