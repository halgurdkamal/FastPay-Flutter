import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fastpay_method_channel.dart';

abstract class FastpayPlatform extends PlatformInterface {
  /// Constructs a FastpayPlatform.
  FastpayPlatform() : super(token: _token);

  static final Object _token = Object();

  static FastpayPlatform _instance = MethodChannelFastpay();

  /// The default instance of [FastpayPlatform] to use.
  ///
  /// Defaults to [MethodChannelFastpay].
  static FastpayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FastpayPlatform] when
  /// they register themselves.
  static set instance(FastpayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion(Map<String, dynamic> fastPayData) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
