import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/auth_repository.dart';

part 'account_screen_controller.g.dart';

@riverpod
class AccountScreenController extends _$AccountScreenController {
  @override
  FutureOr<void> build() {}

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
      state = const AsyncLoading();
      state = await AsyncValue.guard(() => authRepository.signOut());
  }
}

