Future<void> delay(bool addDelay, [int seconds = 1]) {
  if (addDelay) {
    return Future.delayed(Duration(seconds: seconds));
  } else {
    return Future.value();
  }
}
