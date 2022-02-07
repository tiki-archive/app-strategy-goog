#import "GoogleProviderPlugin.h"
#if __has_include(<google_provider/google_provider-Swift.h>)
#import <google_provider/google_provider-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "google_provider-Swift.h"
#endif

@implementation GoogleProviderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGoogleProviderPlugin registerWithRegistrar:registrar];
}
@end
