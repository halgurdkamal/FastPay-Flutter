import 'fastpay_platform_interface.dart';

// test jest string
// class Fastpay {
//   Future<String?> getPlatformVersion() {
//     return FastpayPlatform.instance.getPlatformVersion();
//   }
// }

class Fastpay {
  Future<String?> getPlatformVersion(Map<String, dynamic> fastPayData) {
    return FastpayPlatform.instance.getPlatformVersion(fastPayData);
  }
}
