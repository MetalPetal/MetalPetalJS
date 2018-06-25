//
//  MTIJSExtension.h
//  Pods
//
//  Created by Yu Ao on 2018/6/25.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>
#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTIJSEnvironment <JSExport>

@property (nonatomic, class, copy, readonly) NSString *mainBundlePath;

+ (NSString *)pathByAppendingPathComponent:(NSString *)pathComponent toPath:(NSString *)path;

@end

@interface MTIJSExtension : NSObject

+ (void)exportToJSContext:(JSContext *)context;

@end

@interface JSValue (MTIJSExtension)

+ (JSValue *)valueWithMTITextureDimensions:(MTITextureDimensions)dimensions inContext:(JSContext *)context;

- (MTITextureDimensions)toMTITextureDimensions;

+ (JSValue *)valueWithMTIColor:(MTIColor)color inContext:(JSContext *)context;

- (MTIColor)toMTIColor;

@end

@interface NSObject (MTIJSExtension)

+ (void)mti_exportToJSContext:(JSContext *)context;

@end

NS_ASSUME_NONNULL_END
