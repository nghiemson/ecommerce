import 'package:ecommerce_app/src/features/checkout/data/banks_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          crossAxisCount: 3,
        ),
        itemBuilder: (_, index) {
          return responseAsync.when(
            data: (response) {
              final bank = response.banks.values.toList()[index];
              return Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: bank.bankLogoUrl,
                  ),
                  Text(bank.shortName)
                ],
              );
            },
            loading: () => const CupertinoActivityIndicator(),
            error: (err, stack) => Text(err.toString()),
          );
        },
      ),
    );
  }
}
