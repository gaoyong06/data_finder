
import 'dart:async';

import 'package:flutter/services.dart';

class DataFinder {
  static const MethodChannel _channel =
      const MethodChannel('data_finder');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
