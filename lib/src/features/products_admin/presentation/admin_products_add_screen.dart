import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/async_value_widget.dart';
import '../../../routing/app_router.dart';
import '../../products/domain/product.dart';
import '../../products/presentation/products_list/product_card.dart';
import '../../products/presentation/products_list/products_grid.dart';
import '../data/template_products_provider.dart';

class AdminProductsAddScreen extends ConsumerWidget {
  const AdminProductsAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a product'.hardcoded),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: Colors.grey.shade400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Choose a product from template'.hardcoded,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Expanded(
            child: CustomScrollView(
              slivers: [
                // Choose from template
                ProductsTemplateGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A widget used to show all the template products
class ProductsTemplateGrid extends ConsumerWidget {
  const ProductsTemplateGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Note: loading from the  "template" products provider
    final productsListValue = ref.watch(templateProductsListProvider);
    return AsyncValueSliverWidget<List<Product>>(
      value: productsListValue,
      data: (products) => SliverProductsAlignedGrid(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onPressed: () => context.goNamed(
              AppRoute.adminUploadProduct.name,
              pathParameters: {'id': product.id},
            ),
          );
        },
      ),
    );
  }
}