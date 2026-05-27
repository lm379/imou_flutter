import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../model/access_token_response.dart';

class ImouConnect {
  // id is random string, will return in response
  static Future<AccessTokenResponse?> getAccessToken(
      {required String appId,
      required String id,
      required String appSecret}) async {
    String serverUrl = 'https://openapi.lechange.cn:443/openapi/accessToken';
    String nonce = Uuid().v4();
    int time = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    var initialBody = {
      "system": {
        "ver": "1.0",
        "appId": appId,
        "sign": _generateMd5(
            _getSign(time: time, nonce: nonce, appSecret: appSecret)),
        "time": time,
        "nonce": nonce
      },
      "id": id,
      "params": {}
    };

    try {
      var req = await Dio().post(serverUrl, data: initialBody);
      debugPrint('ImouConnect response: ${req.data}');
      return AccessTokenResponse.fromJson(json.decode(req.data));
    } catch (e) {
      debugPrint('ImouConnect getAccessToken failed: $e');
      return null;
    }
  }

  static String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String _getSign(
      {required int time, required String nonce, required String appSecret}) {
    return 'time:$time,nonce:$nonce,appSecret:$appSecret';
  }
}
