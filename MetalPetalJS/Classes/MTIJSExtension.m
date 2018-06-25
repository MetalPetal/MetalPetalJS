//
//  MTIJSExtension.m
//  Pods
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIJSExtension.h"
#import "MTIImageJSSupport.h"
#import "MTIFilterJSSupport.h"

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
    [context setObject:@{@"unknown": @(MTIAlphaTypeUnknown),
                         @"nonPremultiplied": @(MTIAlphaTypeNonPremultiplied),
                         @"premultiplied": @(MTIAlphaTypePremultiplied),
                         @"alphaIsOne": @(MTIAlphaTypeAlphaIsOne)}
     forKeyedSubscript:@"MTIAlphaType"];
    
    [MTIImage mti_exportToJSContext:context];
    [MTIJSEnvironment mti_exportToJSContext:context];
    [MTIFilterJSSupport exportToContext:context];
}
    
@end

@implementation NSObject (MTIJSExtension)

+ (void)mti_exportToJSContext:(JSContext *)context {
    [context setObject:self forKeyedSubscript:NSStringFromClass(self)];
}

@end
