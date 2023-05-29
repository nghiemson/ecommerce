import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';

class FakeAppUser extends AppUser {
  FakeAppUser({
    required this.password,
    required super.uid,
    required super.email,
  });

  final String password;
}
