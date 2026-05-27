import 'package:imou_plugin/controller/platform_event.dart';
import 'package:flutter/services.dart';
import 'package:imou_plugin/model/camera_view_options.dart';

/// Controller for a single Camera instance running on the host platform.
class CameraViewController {
  late MethodChannel _methodChannel;

  CameraViewController(int id) {
    _methodChannel = MethodChannel('imou_plugin/$id');
    _methodChannel.setMethodCallHandler(_handleMethod);
  }

  void initSDK(CameraViewOptions options) {
    _methodChannel.invokeMethod(PlatformEvent.initSDK.name, options.toJson());
  }

  /// Generic Handler for Messages sent from the Platform
  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'sendFromNative':
        String? text = call.arguments as String?;
        return Future.value("Text from native: $text");
    }
  }
}
