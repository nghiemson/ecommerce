import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/domain/fake_app_user.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeAuthRepository {
  FakeAuthRepository({this.addDelay = true});

  final bool addDelay;
  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;

  AppUser? get currentUser => _authState.value;

  // list to keep track of all users
  final List<FakeAppUser> _users = [];

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);
    //check the given credentials against each registered user
    for(final u in _users) {
      // matching
      if (u.email == email && u.password == password) {
        _authState.value = u;
        return;
      }
      //same email, wrong password
      if (u.email == email && u.password != password) {
        throw WrongPasswordException();
      }
    }
    throw UserNotFoundException();
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await delay(addDelay);
    // check if email is already in use
    for (final u in _users) {
      if (u.email == email) {
        throw EmailAlreadyInUseException();
      }
    }
    // min length password require
    if (password.length < 8) {
      throw WeakPasswordException();
    }
    // create new user
    _createNewUser(email, password);
  }

  Future<void> signOut() async {
    _authState.value = null;
  }

  void _createNewUser(String email, String password) {
    // create new user
    final user = FakeAppUser(
      uid: email.split('').reversed.join(),
      email: email,
      password: password,
    );
    // register it
    _users.add(user);
    // update the auth state
    _authState.value = user;
  }

  void dispose() => _authState.close();
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final auth = FakeAuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return authRepo.authStateChanges();
});
