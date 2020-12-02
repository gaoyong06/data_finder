<!--
 * @Author: your name
 * @Date: 2020-11-30 13:24:58
 * @LastEditTime: 2020-12-02 14:11:10
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /data_finder/README.md
-->
|      |      |
| ---- | ---- |
|  作者    |  [gaoyong](mailto:gaoyong06@qq.com) |
|  创建时间    | 2020-11-30 12:56:02      |

# data_finder

data_finder是一个flutter插件

## 介绍

data_finder是一个flutter插件，在flutter平台实现了字节跳动的[DataFinder](https://datarangers.com.cn/product/datafinder)的功能


## 主要功能

- 设备注册/激活
  - 初始化（start）
  - 登录态变化调用（setCurrentUserUniqueID）

- 手动上班用户行为日志
  - 通过代码上报行为埋点（eventV3）

- 可视化圈选埋点

## ios配置

- 第一步
  
  在/Users/gaoyong/Documents/work/data_finder/example/ios/Podfile 文件中增加
  source 'https://github.com/bytedance/cocoapods_sdk_source_repo.git'
  示例程序[Podfile](...)


- 第二步
  
  在/Users/gaoyong/Documents/work/data_finder/ios/data_finder.podspec 文件中增加
  s.subspec 'RangersAppLog' do |cs|
    cs.dependency 'RangersAppLog/Host/CN'
    cs.dependency 'RangersAppLog/Core'
    cs.dependency 'RangersAppLog/Unique'
    cs.dependency 'RangersAppLog/UITracker'
    cs.dependency 'RangersAppLog/Log'
    cs.dependency 'RangersAppLog/Picker'
  end
  示例程序[data_finder.podspec](...)

## 添加URL Scheme

  [参考示例](https://datarangers.com.cn/help/doc?lid=1097&did=8547#_4-%E6%B7%BB%E5%8A%A0url-scheme)


- 第三步
 在/Users/gaoyong/Documents/work/data_finder/example/ 目录下执行
  pod install --repo-update

## 在ios上测试

- flutter run
- flutter build ios --no-codesign
  
## 问题记录

- [!] The 'Pods-Runner' target has transitive dependencies that include statically linked binaries: (RangersAppLog)
  
  处理办法：修改/Users/gaoyong/Documents/work/data_finder/example/ios/Podfile 注释掉 use_frameworks!
  将use_frameworks! 修改为 #use_frameworks!

- [!] Automatically assigning platform `iOS` with version `9.0` on target `Runner` because no platform was specified. Please specify a platform for this target in your Podfile. See `https://guides.cocoapods.org/syntax/podfile.html#platform`.

  处理办法：修改/Users/gaoyong/Documents/work/data_finder/example/ios/Podfile 打开注释 # platform :ios, '9.0'
  将# platform :ios, '9.0' 修改为 platform :ios, '9.0'

- [!] CocoaPods did not set the base configuration of your project because your project already has a custom config set. In order for CocoaPods integration to work at all, please either set the base configurations of the target `Runner` to `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` or include the `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` in your build configuration (`Flutter/Release.xcconfig`).
  
  处理办法：见图示

- Action Required: You must set a build name and number in the pubspec.yaml file version field before submitting to the App Store.



Unable to install /Users/gaoyong/Documents/work/data_finder/example/build/ios/iphonesimulator/Runner.app on 3CBAC47F-E2D4-426A-B0DE-72D995143902. This is sometimes caused by a malformed plist file:
ProcessException: Process exited abnormally:
An error was encountered processing the command (domain=NSPOSIXErrorDomain, code=22):
Failed to install the requested application
The application's Info.plist does not contain CFBundleVersion.
Ensure your bundle contains a CFBundleVersion.
  Command: /usr/bin/xcrun simctl install 3CBAC47F-E2D4-426A-B0DE-72D995143902 /Users/gaoyong/Documents/work/data_finder/example/build/ios/iphonesimulator/Runner.app
Error launching application on iPhone 12 Pro Max.

$(FLUTTER_BUILD_NUMBER)

Unable to install /Users/gaoyong/Documents/work/data_finder/example/build/ios/iphonesimulator/Runner.app on 3CBAC47F-E2D4-426A-B0DE-72D995143902. This is sometimes caused by a malformed plist file:
ProcessException: Process exited abnormally:
An error was encountered processing the command (domain=NSPOSIXErrorDomain, code=22):
Failed to install the requested application
The application's Info.plist does not contain CFBundleShortVersionString.
Ensure your bundle contains a CFBundleShortVersionString.
  Command: /usr/bin/xcrun simctl install 3CBAC47F-E2D4-426A-B0DE-72D995143902 /Users/gaoyong/Documents/work/data_finder/example/build/ios/iphonesimulator/Runner.app
Error launching application on iPhone 12 Pro Max.

$(FLUTTER_BUILD_NAME)

Command PhaseScriptExecution failed with a nonzero exit code

处理办法：Runner project > Info > Configurations 设置错误，正确的设置方法，参考这个[设置和验证方式](https://github.com/flutter/flutter/issues/49495#issuecomment-583066933)



Flutter/Debug.xcconfig:2: could not find included file 'Generated.xcconfig' in search paths

处理办法：https://stackoverflow.com/questions/54321180/error-could-not-find-included-file-generated-xcconfig-in-search-paths-in-tar
因为没有设置签名，所以先执行 flutter build ios --no-codesign

invalid reuse after initialization failure