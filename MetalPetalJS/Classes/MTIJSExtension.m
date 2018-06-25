//
//  MTIJSExtension.m
//  Pods
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIJSExtension.h"
#import "MTIImageJSSupport.h"

@interface MTIJSEnvironment: NSObject <MTIJSEnvironment>

@end

@implementation MTIJSEnvironment

+ (NSString *)mainBundlePath {
    return [NSBundle mainBundle].bundlePath;
}

+ (NSString *)pathByAppendingPathComponent:(NSString *)pathComponent toPath:(NSString *)path {
    return [path stringByAppendingPathComponent:pathComponent];
}

@end

@implementation MTIJSExtension

+ (void)exportToJSContext:(JSContext *)context {
    [MTIImage mti_exportToJSContext:context];
    [MTIJSEnvironment mti_exportToJSContext:context];
}
    
@end

@implementation NSObject (MTIJSExtension)

+ (void)mti_exportToJSContext:(JSContext *)context {
    [context setObject:self forKeyedSubscript:NSStringFromClass(self)];
}

@end
