Future<void> delay(bool addDelay, [int seconds = 2]) {
  if (addDelay) {
    return Future.delayed(Duration(seconds: seconds));
  } else {
    return Future.value();
  }
}
