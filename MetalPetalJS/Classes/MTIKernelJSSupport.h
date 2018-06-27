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

@protocol MTIRenderPipelineKernelJSSupport <JSExport>

@property (nonatomic, class, strong, readonly) MTIRenderPipelineKernel *passthroughRenderPipelineKernel;

@end

@interface MTIRenderPipelineKernel (JSSupport) <MTIRenderPipelineKernelJSSupport, MTIKernelJSSupport>

/*
 {
 "vertexFunction": { "name": "vertex", "library": "/var/private/..../default.metallib"},
 "fragmentFunction": { "name": "frag"}, // if library is null means it is from in MetalPetal's default metalib.
 }
 */

@end

@protocol MTIComputePipelineKernelJSSupport <JSExport>

- (MTIImage *)applyToInputImages:(NSArray<MTIImage *> *)images
                      parameters:(NSDictionary<NSString *,id> *)parameters
         outputTextureDimensions:(MTITextureDimensions)outputTextureDimensions
               outputPixelFormat:(MTLPixelFormat)outputPixelFormat;

@end

@interface MTIComputePipelineKernel (JSSupport) <MTIComputePipelineKernelJSSupport, MTIKernelJSSupport>

/*
 {
 "computeFunction": { "name": "compute", "library": "/var/private/..../default.metallib"},
 }
 */

@end

NS_ASSUME_NONNULL_END

