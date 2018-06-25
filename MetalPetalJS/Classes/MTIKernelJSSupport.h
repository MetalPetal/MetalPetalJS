//
//  MTIKernelJSSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>
#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTIKernelJSSupport <JSExport>

+ (nullable instancetype)kernelWithJSONDescriptor:(NSDictionary *)JSONDescriptor;

@end

@interface MTIRenderPipelineKernel (JSSupport) <MTIKernelJSSupport>

/*
 {
 "vertexFunction": { "name": "vertex", "library": "/var/private/..../default.metallib"},
 "fragmentFunction": { "name": "frag"}, // if library is null means it is from in MetalPetal's default metalib.
 }
 */

@end

@protocol MTIComputePipelineKernelJSSupport <MTIKernelJSSupport>

- (MTIImage *)applyToInputImages:(NSArray<MTIImage *> *)images
                      parameters:(NSDictionary<NSString *,id> *)parameters
         outputTextureDimensions:(MTITextureDimensions)outputTextureDimensions
               outputPixelFormat:(MTLPixelFormat)outputPixelFormat;

@end

@interface MTIComputePipelineKernel (JSSupport) <MTIComputePipelineKernelJSSupport>

/*
 {
 "computeFunction": { "name": "compute", "library": "/var/private/..../default.metallib"},
 }
 */

@end

NS_ASSUME_NONNULL_END

