import 'package:ecommerce_app/src/features/checkout/presentation/checkout_screen/checkout_screen.dart';
import 'package:ecommerce_app/src/features/products_admin/presentation/admin_products_screen.dart';
import 'package:ecommerce_app/src/routing/go_router_refresh_stream.dart';
import 'package:ecommerce_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/data/auth_repository.dart';
import '../features/authentication/presentation/account/account_screen.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import '../features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
import '../features/orders/presentation/orders_list/orders_list_screen.dart';
import '../features/products/presentation/product_screen/product_screen.dart';
import '../features/products/presentation/products_list/products_list_screen.dart';
import '../features/products_admin/presentation/admin_product_edit_screen.dart';
import '../features/products_admin/presentation/admin_product_upload_screen.dart';
import '../features/products_admin/presentation/admin_products_add_screen.dart';
import '../features/review/presentation/leave_review_screen/leave_review_screen.dart';

enum AppRoute {
  home,
  cart,
  orders,
  account,
  signIn,
  product,
  review,
  checkout,
  admin,
  adminAdd,
  adminUploadProduct,
  adminEditProduct,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    redirect: (_, state) {
      final isLoggedIn = authRepo.currentUser != null;
      if (isLoggedIn) {
        if (state.matchedLocation == '/signIn') {
          return '/';
        }
      } else {
        if (state.matchedLocation == '/account' ||
            state.matchedLocation == '/orders') {
          return '/';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepo.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const ProductsListScreen(),
        routes: [
          GoRoute(
              path: 'cart',
              name: AppRoute.cart.name,
              pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const ShoppingCartScreen(),
                  ),
              routes: [
                GoRoute(
                  path: 'checkout',
                  name: AppRoute.checkout.name,
                  pageBuilder: (context, state) => MaterialPage(
                    key: ValueKey(state.matchedLocation),
                    fullscreenDialog: true,
                    child: const CheckoutScreen(),
                  ),
                ),
              ]),
          GoRoute(
            path: 'orders',
            name: AppRoute.orders.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const OrdersListScreen(),
            ),
          ),
          GoRoute(
            path: 'account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const AccountScreen(),
            ),
          ),
          GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.signIn,
              ),
            ),
          ),
          GoRoute(
            path: 'product/:id',
            name: AppRoute.product.name,
            builder: (context, state) {
              final productId = state.pathParameters['id']!;
              return ProductScreen(productId: productId);
            },
            routes: [
              GoRoute(
                path: 'review',
                name: AppRoute.review.name,
                pageBuilder: (context, state) {
                  final productId = state.pathParameters['id']!;
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: LeaveReviewScreen(
                      productId: productId,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'admin',
            name: AppRoute.admin.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AdminProductsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoute.adminAdd.name,
                pageBuilder: (context, state) => const MaterialPage(
                  fullscreenDialog: true,
                  child: AdminProductsAddScreen(),
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    name: AppRoute.adminUploadProduct.name,
                    builder: (context, state) {
                      final productId = state.pathParameters['id']!;
                      return AdminProductUploadScreen(productId: productId);
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'edit/:id',
                name: AppRoute.adminEditProduct.name,
                pageBuilder: (context, state) {
                  final productId = state.pathParameters['id']!;
                  return MaterialPage(
                    fullscreenDialog: true,
                    child: AdminProductEditScreen(productId: productId),
                  );
                },
              ),
            ],
          )
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
