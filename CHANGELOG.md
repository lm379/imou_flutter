## 1.0.0

二改自 [thanhdang198/imou_flutter](https://github.com/thanhdang198/imou_flutter)，进行全面重构与升级。

### 重大变更

- 适配 Dart 3 / Flutter 3.10+（SDK 约束 `>=3.0.0 <4.0.0`）
- dio 从 ^4.0.6 升级至 ^5.8.0
- LCOpenSDK 升级至 V3.12.12
- Android compileSdk 从 31 升级至 34，minSdkVersion 从 16 升级至 21
- API 端点从新加坡区域 (`openapi-sg.easy4ip.com`) 切换至中国区域 (`openapi.lechange.cn`)

### Bug 修复

- 修复 `ImouPlugin.kt` 中 `onDetachedFromActivity` 调用 `activity.finish()` 导致宿主 Activity 被意外关闭的问题
- 修复 `ImouPlugin.kt` 中 MethodChannel 名称错误（`navigation_plugin` → `imou_plugin`）
- 修复 `pubspec.yaml` 缺少 `crypto` 依赖导致编译失败的问题
- 修复 `CameraEvent.fromJson` 中缺少越界检查和错误处理的问题

### 改进

- 移除代码中硬编码的 appId、appSecret 和 deviceId
- `print()` 统一替换为 `debugPrint()`
- 清理未使用的代码、字段和 import
- 测试文件适配新版 `setMockMethodCallHandler` API
- 文档翻译为中文，增加 MIT 开源协议

## 0.0.1

初始版本（原作者 thanhdang198）。
