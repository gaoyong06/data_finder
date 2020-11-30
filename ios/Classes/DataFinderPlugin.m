#import "DataFinderPlugin.h"
#if __has_include(<data_finder/data_finder-Swift.h>)
#import <data_finder/data_finder-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "data_finder-Swift.h"
#endif

@implementation DataFinderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDataFinderPlugin registerWithRegistrar:registrar];
}
@end
