import 'dart:async';

import 'package:flutter/services.dart';

class DataFinder {
  static const MethodChannel _channel = const MethodChannel('data_finder');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///
  /// 初始化dataFinder
  /// 传入appId channel
  ///
  static void initDataFinder(String appId, {String channel = 'app', bool showLog = false}) {
    _channel.invokeMethod("init", {"appId": appId, "channel": channel, "showLog": showLog});
  }

  ///
  ///用户登陆之后传入登陆用户唯一id可传入sid
  ///
  static void setUserUniqueID(String userUniqueID) {
    _channel.invokeMethod("setUserUniqueID", {
      "userUniqueID": userUniqueID,
    });
  }

  ///
  /// 埋点
  /// event为事件名
  /// params为额外参数
  ///
  static void onEventV3(String event, {Map params}) {
    _channel.invokeMethod("onEventV3", {
      "event": event,
      "params": params,
    });
  }
}
