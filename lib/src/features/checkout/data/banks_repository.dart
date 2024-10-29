import 'dart:async';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/dio_provider.dart';
import '../domain/banks_ressponse.dart';

part 'banks_repository.g.dart';

class BanksRepository {
  const BanksRepository({required this.dio});

  final Dio dio;

  Future<BanksResponse> banks({CancelToken? cancelToken}) async {
    final response = await dio.get('https://test-payment.momo.vn/v2/gateway/api/bankcodes');
    return BanksResponse.fromJson({'banks': response.data});
  }
}

@riverpod
BanksRepository banksRepository(BanksRepositoryRef ref) {
  return BanksRepository(dio: ref.watch(dioProvider));
}

class AbortException implements Exception {}
@riverpod
Future<BanksResponse> fetchBanks(FetchBanksRef ref) async {
  final banksRepo = ref.watch(banksRepositoryProvider);
  final cancelToken = CancelToken();
  final link = ref.keepAlive();
  Timer? timer;

  ref.onDispose(() {
    cancelToken.cancel();
    link.close();
    timer?.cancel();
  });
  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), () {
      link.close();
    });
  });

  ref.onResume(() {
    timer?.cancel();
  });
  return banksRepo.banks(cancelToken: cancelToken);
}
