#import "FastpayPlugin.h"
#if __has_include(<fastpay/fastpay-Swift.h>)
#import <fastpay/fastpay-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fastpay-Swift.h"
#endif

@implementation FastpayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFastpayPlugin registerWithRegistrar:registrar];
}
@end
