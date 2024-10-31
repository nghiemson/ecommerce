import 'package:ecommerce_app/src/features/checkout/data/banks_repository.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

/// Payment screen showing the items in the cart (with read-only quantities) and
/// a button to checkout.
class PaymentPage extends ConsumerWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final responseAsync = ref.watch(fetchBanksProvider);
    final totalResults = responseAsync.valueOrNull?.banks.length ?? 0;
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(fetchBanksProvider);
        try {
          await ref.read(fetchBanksProvider.future);
        } catch (e) {
          print(e);
        }
      },
      child: GridView.builder(
        itemCount: totalResults,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (_, index) {
          return responseAsync.when(
            loading: () {
              return const CircularProgressIndicator();
            },
            error: (err, stack) => Text(err.toString()),
            data: (response) {
              final bank = response.banks.values.toList()[index];
              return GestureDetector(
                onTap: () => context.pushNamed(AppRoute.verify.name),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: bank.bankLogoUrl,
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      bank.shortName,
                      style: const TextStyle(fontSize: 11),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
