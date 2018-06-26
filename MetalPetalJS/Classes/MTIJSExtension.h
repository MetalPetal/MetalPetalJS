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

@protocol MTIJSUtilities <JSExport>

JSExportAs(joinPath,
+ (NSString *)joinPath:(NSString *)path pathComponent:(NSString *)pathComponent);

@end

@interface MTIJSExtension : NSObject

+ (void)exportToJSContext:(JSContext *)context;

@end

@interface JSValue (MTIJSExtension)

+ (JSValue *)valueWithMTITextureDimensions:(MTITextureDimensions)dimensions inContext:(JSContext *)context;

- (MTITextureDimensions)toMTITextureDimensions;

+ (JSValue *)valueWithMTIColor:(MTIColor)color inContext:(JSContext *)context;

- (MTIColor)toMTIColor;

+ (JSValue *)valueWithMTIColorMatrix:(MTIColorMatrix)colorMatrix inContext:(JSContext *)context;

- (MTIColorMatrix)toMTIColorMatrix;

@end

@interface NSObject (MTIJSExtension)

+ (void)mti_exportToJSContext:(JSContext *)context;

@end

@interface JSContext (MTIJSExtension)

- (void)mti_garbageCollect;

@end

NS_ASSUME_NONNULL_END
