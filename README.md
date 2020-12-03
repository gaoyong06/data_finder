<!--
 * @Author: gaoyong06@qq.com 
 * @Date: 2020-11-30 12:56:02 
 * @Last Modified by: gaoyong06@qq.com
 * @Last Modified time: 2020-11-30 12:56:02
-->
|      |      |
| ---- | ---- |
|  作者    |  [gaoyong](mailto:gaoyong06@qq.com) |
|  创建时间    | 2020-11-30 12:56:02      |

# data_finder

字节跳动[数据漫游者](https://datarangers.com.cn/)的基础分析产品[数据发现者DataFinder](https://datarangers.com.cn/product/datafinder)的Flutter插件

## 介绍

data_finder是一个flutter plugin，为满足在使用flutter开发的App上使用字节跳动提供的[数据漫游者](https://datarangers.com.cn/)的基础分析产品[数据发现者DataFinder](https://datarangers.com.cn/product/datafinder)而开发的一个flutter plugin，目前支持Android, iOS两个平台
## 主要功能

- 设备注册/激活
  - 初始化dataFinder
  - 用户登录后设置登录用户uuid
- 手动上报用户行为日志
  - 上报行为埋点

## 安装
- 在项目的pubspec.yaml中在增加下面配置：data_finder: ^0.0.3
- 然后在项目根目录(pubspec.yaml 所在的目录)执行命令：flutter pub get

## 使用方法
 - 设备注册/激活
```
  
  //初始化SDK
  //备注：204291为申请的appId
  DataFinder.start("204291", channel: "App Store", showLog: true)

  //登录态变化调用(设置uuid)
  //备注：sf180为系统自身的uid
  DataFinder.setUserUniqueID("sf180")

```
  - 手动上报用户行为日志
```
  
   DataFinder.onEventV3("event_name", params: {
      "params1": "value1",
      "params2": "value2",
   }

```  

**初始化dataFinder** 

方法名称: DataFinder.start

参数说明:

| 参数名称      | 说明                         | 类型               | 默认值 |
| ------------- | ---------------------------- | ------------------ | ------ |
| appId          | 在dataFinder后台申请的appId(应用列表中的应用ID) | String            | -      |
| channel        | 渠道名称,iOS一般默认App Store                   | String             | app     |
| showLog         | 是否在控制台输出日志，可用于观察用户行为日志上报情况          | bool | false     |

示例：
```
  //初始化SDK
  //备注：204291为申请的appId
  DataFinder.start("204291", channel: "App Store", showLog: true)
```

**用户登录后设置登录用户uuid** 

方法名称: DataFinder.setUserUniqueID

参数说明: 

| 参数名称      | 说明                         | 类型               | 默认值 |
| ------------- | ---------------------------- | ------------------ | ------ |
| userUniqueID          | 自己的账号体系ID, 并保证其唯一性 | String            | -      |

示例：
```
  //登录态变化调用(设置uuid)
  //备注：sf180为系统自身的uid
  DataFinder.setUserUniqueID("sf180")
```

**上报行为埋点** 

方法名称: DataFinder.onEventV3

参数说明: 

| 参数名称      | 说明                         | 类型               | 默认值 |
| ------------- | ---------------------------- | ------------------ | ------ |
| event          | 事件名称 | String            | -      |
| params        | 事件属性,一个事件可以对应多个属性                   | Map             |      |

示例：
```
  DataFinder.onEventV3("event_name", params: {
      "params1": "value1",
      "params2": "value2",
   }
```
[示例程序](https://github.com/gaoyong06/data_finder/blob/main/example/lib/main.dart)

## iOS平台配置

- 修改Podfile文件
  
  在/Users/gaoyong/Documents/work/data_finder/example/ios/Podfile 文件中增加
  source 'https://github.com/bytedance/cocoapods_sdk_source_repo.git'
  [示例程序](https://github.com/gaoyong06/data_finder/blob/main/example/ios/Podfile)

- 执行pod install --repo-update
  
  在/Users/gaoyong/Documents/work/data_finder/example/ 目录下执行
  pod install --repo-update

## Android平台配置

- 无需配置
  
## 配置的其他问题

- 理论上按上面的配置就可以正常工作了，如果出现其他问题可能会因为版本或者环境问题导致，可先阅读一下DataFinder的提供的应用[接入文档](https://datarangers.com.cn/help/doc?lid=1097&did=8547)

- 因为现在没有涉及URL Scheme，所以上面没有配置，如果有需要参考接入文档,[iOS添加URL Scheme](https://datarangers.com.cn/help/doc?lid=1097&did=8547#_4-%E6%B7%BB%E5%8A%A0url-scheme) 和[Android添加url scheme](https://datarangers.com.cn/help/doc?lid=1097&did=10942#_2-3-%E6%B7%BB%E5%8A%A0url-scheme)

- 如果在接入过程中遇到其他问题欢迎大家提交issue,或者pr

## 执行示例程序

  如果希望执行一下该项目的示例程序的话看看效果的话，clone 或者 fork 该项目到本地硬盘后，cd 到 ../data_finder/example 目录下后，如果想看一下Android的效果，则cd至android 目录（../data_finder/example/android）执行 flutter run, 如果想看一下iOS的效果，用xcode 打开../data_finder/example/ios/Runner.xcworkspace, 编译执行即可

## 在ios上测试使用的命令

- flutter build ios --no-codesign
- flutter run

## 开发过程中遇到的问题及处理办法

- [!] CocoaPods did not set the base configuration of your project because your project already has a custom config set. In order for CocoaPods integration to work at all, please either set the base configurations of the target `Runner` to `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` or include the `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` in your build configuration (`Flutter/Release.xcconfig`).
  
  >处理办法：[参考文档](https://github.com/flutter/flutter/issues/49495#issuecomment-583066933)

- [!] The 'Pods-Runner' target has transitive dependencies that include statically linked binaries: (RangersAppLog)
  
  >处理办法：修改/Users/gaoyong/Documents/work/data_finder/example/ios/Podfile 注释掉 use_frameworks!
  将use_frameworks! 修改为 #use_frameworks!

- [!] Automatically assigning platform `iOS` with version `9.0` on target `Runner` because no platform was specified. Please specify a platform for this target in your Podfile. See `https://guides.cocoapods.org/syntax/podfile.html#platform`.

  >处理办法：修改/Users/gaoyong/Documents/work/data_finder/example/ios/Podfile 打开注释 # platform :ios, '9.0'
  将# platform :ios, '9.0' 修改为 platform :ios, '9.0'

- Command PhaseScriptExecution failed with a nonzero exit code
  > 处理办法：Runner project > Info > Configurations 设置错误，正确的设置方法，参考这个[设置和验证方式](https://github.com/flutter/flutter/issues/49495#issuecomment-583066933)

- Flutter/Debug.xcconfig:2: could not find included file 'Generated.xcconfig' in search paths

  > 处理办法：https://stackoverflow.com/questions/54321180/error-could-not-find-included-file-generated-xcconfig-in-search-paths-in-tar
  另：如果没有设置签名，则执行 flutter build ios --no-codesign

## 备注
    - *上面文档中提到的目录/Users/gaoyong/Documents/work/data_finder/example 仅为示例，实际场景应该是开发者自己的项目根目录(即含有pubspec.yaml文件的目录)*  