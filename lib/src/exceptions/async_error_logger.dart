import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:ecommerce_app/src/exceptions/error_logger.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncErrorLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final errorLogger = container.read(errorLoggerProvider);
    final error = _findError(newValue);
    if (error != null) {
      if (error.error is AppException) {
        // only print the AppException data
        errorLogger.logAppException(error.error as AppException);
    } else {
        // prints everything including the stacktrace
        errorLogger.logError(error.error, error.stackTrace);
      }
  }
}

AsyncError<dynamic>? _findError(Object? value) {
  if (value is AsyncError) {
    return value;
  } else {
    return null;
  }
}
}
