//
//  MTIRenderCommandJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIRenderCommandJSSupport.h"

@implementation MTIRenderCommand (JSSupport)

+ (instancetype)renderCommandWithKernel:(MTIRenderPipelineKernel *)kernel geometry:(id<MTIGeometry>)geometry images:(NSArray<MTIImage *> *)images parameters:(NSDictionary<NSString *,id> *)parameters {
    return [[MTIRenderCommand alloc] initWithKernel:kernel geometry:geometry images:images parameters:parameters];
}

@end

@implementation MTIRenderPassOutputDescriptor (JSSupport)

+ (instancetype)renderPassOutputDescriptorinitWithDimensions:(MTITextureDimensions)dimensions pixelFormat:(MTLPixelFormat)pixelFormat {
    return [[MTIRenderPassOutputDescriptor alloc] initWithDimensions:dimensions pixelFormat:pixelFormat];
}

+ (instancetype)renderPassOutputDescriptorinitWithDimensions:(MTITextureDimensions)dimensions pixelFormat:(MTLPixelFormat)pixelFormat loadAction:(MTLLoadAction)loadAction {
    return [[MTIRenderPassOutputDescriptor alloc] initWithDimensions:dimensions pixelFormat:pixelFormat loadAction:loadAction];
}

@end
