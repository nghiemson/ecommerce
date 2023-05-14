import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testEmail = 'test@mail.com';
  const testPW = '1234';
  final testUser = AppUser(
    uid: testEmail.split('').reversed.join(),
    email: testEmail,
  );
  FakeAuthRepository makeAuthRepo() => FakeAuthRepository(addDelay: false);

  group('FakeAuthRepo', () {
    test('currentUser is null', () {
      final authRepo = makeAuthRepo();
      addTearDown(authRepo.dispose);
      expect(authRepo.currentUser, null);
      expect(authRepo.authStateChanges(), emits(null));
    });

    test('currentUser is not null after sign in', () async {
      final authRepo = makeAuthRepo();
      addTearDown(authRepo.dispose);
      await authRepo.signInWithEmailAndPassword(testEmail, testPW);
      expect(authRepo.currentUser, testUser);
      expect(authRepo.authStateChanges(), emits(testUser));
    });

    test('currentUser is not null after registration', () async {
      final authRepo = makeAuthRepo();
      addTearDown(authRepo.dispose);
      await authRepo.createUserWithEmailAndPassword(testEmail, testPW);
      expect(authRepo.currentUser, testUser);
      expect(authRepo.authStateChanges(), emits(testUser));
    });

    test('currentUser is null after sign out', () async {
      final authRepo = makeAuthRepo();
      addTearDown(authRepo.dispose);
      await authRepo.signInWithEmailAndPassword(testEmail, testPW);
      await authRepo.signOut();
      expect(authRepo.currentUser, null);
      expect(authRepo.authStateChanges(), emits(null));
    });

    test('sign in after dispose throws exception', () {
      final authRepo = makeAuthRepo();
      addTearDown(authRepo.dispose);
      authRepo.dispose();
      expect(() => authRepo.createUserWithEmailAndPassword(testEmail, testPW),
          throwsStateError);
      expect(authRepo.authStateChanges(), emits(null));
    });
  });
}
