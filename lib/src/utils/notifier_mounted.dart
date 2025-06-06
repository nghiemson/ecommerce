mixin NotifierMounted {
  bool _mounted = true;

  // Set the notifier as unmounted
  void setUnmounted() => _mounted = false;

  // Whether the notifier is currently mounted
  bool get mounted => _mounted;
}