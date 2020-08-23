
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterVideo {
  static const MethodChannel _channel =
      const MethodChannel('flutter_video');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
