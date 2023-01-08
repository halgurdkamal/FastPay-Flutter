import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fastpay_platform_interface.dart';

/// An implementation of [FastpayPlatform] that uses method channels.
class MethodChannelFastpay extends FastpayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fastpay');

  @override
  Future<String?> getPlatformVersion(Map<String, dynamic> fastPayData) async {
    final version = await methodChannel.invokeMethod<String>(
        'FastPayRequest', fastPayData);
    return version;
  }
}
