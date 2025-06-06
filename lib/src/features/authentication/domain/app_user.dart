/// Simple class representing the user UID and email.

typedef UserID = String;
class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    this.emailVerified = false,
  });
  final UserID uid;
  final String? email;
  final bool emailVerified;

  @override
  String toString() {
    return 'AppUser{uid: $uid, email: $email}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email &&
          emailVerified == other.emailVerified;

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;
}
