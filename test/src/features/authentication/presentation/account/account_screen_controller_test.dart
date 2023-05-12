import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  group('AccountScreenController', () {
    test('initial state is AsyncValue.data', () {
      final authRepository = MockAuthRepository();
      final controller =
          AccountScreenController(authRepository: authRepository);
      expect(controller.debugState, const AsyncData<void>(null));
      verifyNever(authRepository.signOut);
    });

    test('signOut success', () async {
      //setup
      final authRepository = MockAuthRepository();
      when(authRepository.signOut).thenAnswer((_) => Future.value());
      final controller =
          AccountScreenController(authRepository: authRepository);
      expectLater(
          controller.stream,
          emitsInOrder(const [
            AsyncLoading<void>(),
            AsyncData<void>(null),
          ]));
      //run
      await controller.signOut();
      //verify
      verify(authRepository.signOut).called(1);
    },
      timeout: const Timeout(Duration(microseconds: 500)),
    );

    test('signOut failure', () async {
      //setup
      final authRepository = MockAuthRepository();
      final exception = Exception('Connection failed');
      when(authRepository.signOut).thenThrow(exception);
      final controller =
          AccountScreenController(authRepository: authRepository);
      //run
      await controller.signOut();
      //verify
      verify(authRepository.signOut).called(1);
      expect(controller.debugState.hasError, true);
      expect(controller.debugState, isA<AsyncError>());
    });
  });
}
