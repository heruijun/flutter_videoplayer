#import "FlutterVideoPlugin.h"
#if __has_include(<flutter_video/flutter_video-Swift.h>)
#import <flutter_video/flutter_video-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_video-Swift.h"
#endif

@implementation FlutterVideoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterVideoPlugin registerWithRegistrar:registrar];
}
@end
