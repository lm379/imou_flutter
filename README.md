# Imou (乐橙) Flutter SDK 插件

基于乐橙 LCOpenSDK 封装的 Flutter 插件

本项目二改自 [thanhdang198/imou_flutter](https://github.com/thanhdang198/imou_flutter)，在其基础上进行了以下改进：

- 适配 Dart 3 / Flutter 3.10+
- 升级 LCOpenSDK 至 V3.12.12
- 修复若干 Bug（Activity 泄漏、channel 命名错误等）
- API 端点切换至中国区域服务器
- 代码规范化与清理

## 功能

- 实时视频预览
- 云台控制
- 对讲功能
- 截图/录像
- 视频质量切换

## 引入方式

> **注意：** 本插件无法通过 `flutter pub add` 或 pub.dev 直接获取，请使用以下方式引入。

### 方式一：本地路径引入（推荐）

```yaml
dependencies:
  imou_plugin:
    path: plugins/imou_flutter
```

### 方式二：Git 引入

```yaml
dependencies:
  imou_plugin:
    git:
      url: https://github.com/lm379/imou_flutter
      ref: release
```

## 使用方法

### 1. 获取 Access Token

Access Token 建议在后端获取，不建议将 `appId` 和 `appSecret` 编码在前端

```dart
import 'package:imou_plugin/repository/get_access_token.dart';

final response = await ImouConnect.getAccessToken(
  appId: 'your_app_id',
  appSecret: 'your_app_secret',
  id: 'random_string',
);

if (response != null) {
  final accessToken = response.result.data.accessToken;
}
```

### 2. 创建摄像头视图

```dart
import 'package:imou_plugin/embeed/camera_view.dart';
import 'package:imou_plugin/model/camera_view_options.dart';

CameraView(
  cameraViewOptions: CameraViewOptions(
    accessToken: accessToken,
    deviceId: 'device_serial',
    channelId: 0,
    psk: 'device_key',
    playToken: '',
    bateMode: 0,
    isOpt: true,
    isOpenAudio: true,
    imageSize: 300,
  ),
  onCreated: (controller) {
    controller.initSDK(options);
  },
)
```

## Android 配置

### 权限

在 `AndroidManifest.xml` 中添加以下权限：

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

### 混淆规则

在 `proguard-rules.pro` 中添加：

```proguard
-keep class com.lechange.** { *; }
-keep class com.google.gson.** { *; }
```

## iOS 配置

最低支持 iOS 12.0，需要在 Xcode 中配置相应的权限描述。

## API 端点

默认使用中国区域服务器：`https://openapi.lechange.cn:443`

如需切换区域，请修改 `get_access_token.dart` 中的 `serverUrl` 和原生代码中的服务器地址。

## 依赖

- Flutter >= 3.10.0
- Dart >= 3.0.0
- dio >= 5.8.0
- crypto >= 3.0.6
- uuid >= 4.5.1

## SDK 版本

- Android: LCOpenSDK V3.12.12
- iOS: LCOpenMediaSDK

## 致谢

- [thanhdang198](https://github.com/thanhdang198) — 原始 imou_flutter 插件作者

## 开源协议

本项目基于 [MIT License](LICENSE) 开源。
