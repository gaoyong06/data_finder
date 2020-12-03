/*
 * @Author: gaoyong06@qq.com 
 * @Date: 2020-11-30 12:56:02 
 * @Last Modified by: gaoyong06@qq.com
 * @Last Modified time: 2020-11-30 12:56:02
 */
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
  /// String appId: 在dataFinder后台申请的appId(应用列表中的应用ID)
  /// String channel: 渠道名称,iOS一般默认App Store
  /// bool showLog: 是否在控制台输出日志，可用于观察用户行为日志上报情况
  static void start(String appId,
      {String channel = 'app', bool showLog = false}) {
    _channel.invokeMethod(
        "start", {"appId": appId, "channel": channel, "showLog": showLog});
  }

  ///
  /// 用户登录后设置登录用户uuid
  /// String userUniqueID: 自己的账号体系ID, 并保证其唯一性
  static void setUserUniqueID(String userUniqueID) {
    _channel.invokeMethod("setUserUniqueID", {
      "userUniqueID": userUniqueID,
    });
  }

  ///
  /// 上报行为埋点
  /// String event: 事件名称
  /// Map params: 事件属性,一个事件可以对应多个属性
  static void onEventV3(String event, {Map params}) {
    _channel.invokeMethod("onEventV3", {
      "event": event,
      "params": params,
    });
  }
}
