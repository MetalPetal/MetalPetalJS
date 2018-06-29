//
//  MTIJSExtension.m
//  Pods
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIJSExtension.h"
#import "MTIImageJSSupport.h"
#import "MTIFilterJSSupport.h"
#import "MTIVectorJSSupport.h"
#import "MTISIMDTypeKVCSupport.h"

@interface MTIJSUtilities: NSObject <MTIJSUtilities>

@end

@implementation MTIJSUtilities

+ (NSString *)joinPath:(NSString *)path pathComponent:(NSString *)pathComponent {
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
    
    [context setObject:@{@"transient": @(MTIImageCachePolicyTransient),
                         @"persistent": @(MTIImageCachePolicyPersistent)}
     forKeyedSubscript:@"MTIImageCachePolicy"];
    
    [context setObject:@{@"pixel": @(MTILayerLayoutUnitPixel),
                         @"fractionOfBackgroundSize": @(MTILayerLayoutUnitFractionOfBackgroundSize)}
     forKeyedSubscript:@"MTILayerLayoutUnit"];
    
    [context setObject:@{@"red": @(MTIColorComponentRed),
                         @"green": @(MTIColorComponentGreen),
                         @"blue": @(MTIColorComponentBlue),
                         @"alpha": @(MTIColorComponentAlpha)}
     forKeyedSubscript:@"MTIColorComponent"];
    
    [context setObject:@{@"normal": @(MTIMaskModeNormal),
                         @"oneMinusMaskValue": @(MTIMaskModeOneMinusMaskValue)}
     forKeyedSubscript:@"MTIMaskMode"];
    
    [context setObject:@{@"mainBundlePath": [NSBundle mainBundle].bundlePath,
                         @"operatingSystemVersion": NSProcessInfo.processInfo.operatingSystemVersionString
                         } forKeyedSubscript:@"MTIJSEnvironment"];
    
    MTISIMDTypeExportToJSContext(context);
    [MTIJSUtilities mti_exportToJSContext:context];
    [MTIFilterJSSupport exportToContext:context];
    [MTIImage mti_exportToJSContext:context];
    [MTIRenderPipelineKernel mti_exportToJSContext:context];
    [MTIComputePipelineKernel mti_exportToJSContext:context];
    [MTIMPSKernel mti_exportToJSContext:context];
    [MTIRenderCommand mti_exportToJSContext:context];
    [MTIVertices mti_exportToJSContext:context];
    [MTIVector mti_exportToJSContext:context];
    [MTIRenderPassOutputDescriptor mti_exportToJSContext:context];
    [MTIMask mti_exportToJSContext:context];
    [MTILayer mti_exportToJSContext:context];
    
    NSURL *sourceURL = [[NSBundle bundleForClass:self] URLForResource:@"MetalPetal" withExtension:@"js"];
    [context evaluateScript:[NSString stringWithContentsOfURL:sourceURL encoding:NSUTF8StringEncoding error:nil] withSourceURL:sourceURL];
}
    
@end

@implementation JSValue (MTIJSExtension)

+ (JSValue *)valueWithMTITextureDimensions:(MTITextureDimensions)dimensions inContext:(JSContext *)context {
    return [JSValue valueWithObject:@{@"width": @(dimensions.width),
                                      @"height": @(dimensions.height),
                                      @"depth": @(dimensions.depth)}
                          inContext:context];
}

- (MTITextureDimensions)toMTITextureDimensions {
    return (MTITextureDimensions){
        .width = [self[@"width"] toUInt32],
        .height = [self[@"height"] toUInt32],
        .depth = [self[@"depth"] toUInt32]
    };
}

+ (JSValue *)valueWithMTIColor:(MTIColor)color inContext:(JSContext *)context {
    return [JSValue valueWithObject:@{@"red": @(color.red),
                                      @"green": @(color.green),
                                      @"blue": @(color.blue),
                                      @"alpha": @(color.alpha)}
                          inContext:context];
}

- (MTIColor)toMTIColor {
    return (MTIColor){
        .red = [self[@"red"] toDouble],
        .green = [self[@"green"] toDouble],
        .blue = [self[@"blue"] toDouble],
        .alpha = [self[@"alpha"] toDouble]
    };
}

+ (JSValue *)valueWithMTIColorMatrix:(MTIColorMatrix)colorMatrix inContext:(JSContext *)context {
    return [JSValue valueWithObject:@{@"matrix": [JSValue valueWithObject:[MTIVector vectorWithFloat4x4:colorMatrix.matrix] inContext:context],
                                      @"bias": [JSValue valueWithObject:[MTIVector vectorWithFloat4:colorMatrix.bias] inContext:context]}
                          inContext:context];
}

- (MTIColorMatrix)toMTIColorMatrix {
    return (MTIColorMatrix){
        .matrix = [[self[@"matrix"] toObjectOfClass:[MTIVector class]] float4x4Value],
        .bias = [[self[@"bias"] toObjectOfClass:[MTIVector class]] float4Value]
    };
}

@end

@implementation NSObject (MTIJSExtension)

+ (void)mti_exportToJSContext:(JSContext *)context {
    [context setObject:self forKeyedSubscript:NSStringFromClass(self)];
}

@end

#import <dlfcn.h>

@implementation JSContext (MTIJSExtension)

typedef void(*JSCGCFunctionPtr)(JSContextRef);

static JSCGCFunctionPtr JSCGCFunction;

- (void)mti_garbageCollect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:JSContext.class];
        void *frameworkHandler = dlopen(bundle.executablePath.UTF8String, RTLD_NOW);
        NSString *name = [@[@"JS",@"Synchronous",@"GarbageCollect",@"ForDebugging"] componentsJoinedByString:@""];
        JSCGCFunction = dlsym(frameworkHandler , name.UTF8String);
        NSAssert(JSCGCFunction, @"");
    });
    JSCGCFunction(self.JSGlobalContextRef);
}

@end
