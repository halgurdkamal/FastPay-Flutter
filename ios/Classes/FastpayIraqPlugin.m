#import "FastpayIraqPlugin.h"
#if __has_include(<fastpay_iraq/fastpay_iraq-Swift.h>)
#import <fastpay_iraq/fastpay_iraq-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fastpay_iraq-Swift.h"
#endif

@implementation FastpayIraqPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFastpayPlugin registerWithRegistrar:registrar];
}
@end
