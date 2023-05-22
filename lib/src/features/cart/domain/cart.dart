import 'dart:convert';

import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter/foundation.dart';

/// Model class representing the shopping cart contents.
class Cart {
  const Cart([this.items = const {}]);

  /// All the items in the shopping cart, where:
  /// - key: product ID
  /// - value: quantity
  final Map<ProductID, int> items;

  Map<String, dynamic> toMap() {
    return {
      'items': items,
    };
  }

  @override
  String toString() => 'Cart{items: $items}';

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      Map<ProductID, int>.from(map['items']),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(jsonDecode(source));

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Cart && mapEquals(items, other.items);

  @override
  int get hashCode => items.hashCode;
}

extension CartItems on Cart {
  List<Item> toItemsList() {
    return items.entries.map((entry) {
      return Item(
        productId: entry.key,
        quantity: entry.value,
      );
    }).toList();
  }
}
