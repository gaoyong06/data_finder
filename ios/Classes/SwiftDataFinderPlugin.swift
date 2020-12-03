/*
 * @Author: gaoyong06@qq.com
 * @Date: 2020-12-02 18:27:23
 * @Last Modified by: gaoyong06@qq.com
 * @Last Modified time: 2020-12-02 18:27:23
 */
import Flutter
import UIKit
import RangersAppLog

//datafinder ios插件类
//参考文档：https://datarangers.com.cn/help/doc?lid=1097&did=8547
public class SwiftDataFinderPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "data_finder", binaryMessenger: registrar.messenger())
    let instance = SwiftDataFinderPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
    case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion);
    case "start":
        start(call: call, result: result);
    case "setUserUniqueID":
        setUserUniqueID(call: call, result: result);
    case "onEventV3":
        onEventV3(call: call, result: result);
    default:
        result(FlutterMethodNotImplemented);
    }
  }
    
  //初始化SDK
  private func start(call: FlutterMethodCall, result: FlutterResult) {
    
    let arguments: [String:Any] = call.arguments as! [String:Any]
    print("start run, \(arguments)");
    let appId: String = arguments["appId"] as? String ?? "";
    let channel: String = arguments["channel"] as? String ?? ""
    let showLog: Bool = arguments["showLog"] as? Bool ?? false
    let appName: String = arguments["appName"] as? String ?? ""
    
    // Override point for customization after application launch.
    let config = BDAutoTrackConfig(appID: appId) // 如不清楚请联系专属客户成功经理
    config.appName = appName // 与您申请APPID时的app_name一致

    /* 只支持上报到国内: BDAutoTrackServiceVendorCN，上报国外请使用 BDAutoTrackServiceVendorSG，5.5.0 及以上版本可以参考第 2 节的说明*/
    config.serviceVendor = BDAutoTrackServiceVendor.CN;
    config.channel = channel // iOS一般默认App Store
    config.showDebugLog = showLog // 是否在控制台输出日志，仅调试使用。release版本请设置为 false
    config.logNeedEncrypt = true // 是否加密日志，默认加密。release版本请设置为 true
    config.autoTrackEnabled = true
    
    //TODO: 2020-12-02 17:50:11.685114+0800 Runner[23448:265034] [] nw_protocol_get_quic_image_block_invoke dlopen libquic failed
    BDAutoTrack.start(with: config)
    return result(true)
  }
    
  //登录态变化调用(设置uuid)
  private func setUserUniqueID(call: FlutterMethodCall, result: FlutterResult) {
    
    let arguments: [String:Any] = call.arguments as! [String:Any]
    print("setUserUniqueID run, \(arguments)");
    let userUniqueID: String = arguments["userUniqueID"] as? String ?? ""
    BDAutoTrack.setCurrentUserUniqueID(userUniqueID)
    return result(true)
  }
    
  //通过代码上报行为埋点
  private func onEventV3(call: FlutterMethodCall, result: FlutterResult) {
    
    let arguments: [String:Any] = call.arguments as! [String:Any]
    print("onEventV3 run, \(arguments)");
    let event: String = arguments["event"] as? String ?? ""
    let params:[String:Any]? = arguments["event"] as? [String:Any] ?? nil
    BDAutoTrack.eventV3(event, params: params)
    return result(true)
  }
}
