import 'package:flutter/cupertino.dart';

class LockMode extends ChangeNotifier {
  bool _isLock = false;

  bool get isLock => _isLock;

  setLock(bool value) {
    if (isLock == value) return;
    _isLock = value;
    notifyListeners();
  }
}
