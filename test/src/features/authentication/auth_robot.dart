import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpAccountScreen({FakeAuthRepository? authRepository}) async {
    await tester.pumpWidget(
       ProviderScope(
        overrides: [
          if(authRepository != null)
          authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: const MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  Future<void> tapLogoutButton() async {
    final logOutButton = find.text('Logout');
    expect(logOutButton, findsOneWidget);
    await tester.tap(logOutButton);
    await tester.pump();
  }

  Future<void> tapDialogLogoutButton() async {
    final logOutButton = find.byKey(kDialogDefaultKey);
    expect(logOutButton, findsOneWidget);
    await tester.tap(logOutButton);
    await tester.pump();
  }

  void expectLogoutDialogFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsOneWidget);
  }

  Future<void> tapCancelButton() async {
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
    await tester.tap(cancelButton);
    await tester.pump();
  }

  void expectLogoutDialogNotFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsNothing);
  }

  void expectErrorAlertFound() {
    final finder = find.text('Error');
    expect(finder, findsOneWidget);
  }

  void expectErrorAlertNotFound() {
    final finder = find.text('Error');
    expect(finder, findsNothing);
  }
}