import 'package:flutter/foundation.dart';

import 'platform_event.dart';

class CameraEvent {
  PlatformEvent? eventType;
  dynamic data;

  CameraEvent({this.eventType, this.data});

  CameraEvent.fromJson(Map<String, dynamic> json) {
    if (json['eventType'] is int) {
      final index = json['eventType'] as int;
      if (index >= 0 && index < PlatformEvent.values.length) {
        eventType = PlatformEvent.values[index];
      } else {
        debugPrint('CameraEvent.fromJson: invalid eventType index: $index');
      }
    } else {
      try {
        eventType = PlatformEvent.values.firstWhere(
            (e) => e.toString().split(".").last == json['eventType']);
      } on StateError {
        debugPrint(
            'CameraEvent.fromJson: unknown eventType: ${json['eventType']}');
      } catch (e) {
        debugPrint('CameraEvent.fromJson: unexpected error: $e');
      }
    }
  }
}
