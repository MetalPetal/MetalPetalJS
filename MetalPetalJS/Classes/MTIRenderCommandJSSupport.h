//
//  MTIRenderCommandJSSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>
#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTIRenderCommandJSSupport <JSExport>

@property (nonatomic, strong, readonly) MTIRenderPipelineKernel *kernel;

@property (nonatomic, copy, readonly) id<MTIGeometry> geometry;

@property (nonatomic, copy, readonly) NSArray<MTIImage *> *images;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, id> *parameters;

+ (instancetype)renderCommandWithKernel:(MTIRenderPipelineKernel *)kernel
                               geometry:(id<MTIGeometry>)geometry
                                 images:(NSArray<MTIImage *> *)images
                             parameters:(NSDictionary<NSString *,id> *)parameters;

+ (NSArray<MTIImage *> *)imagesByPerformingRenderCommands:(NSArray<MTIRenderCommand *> *)renderCommands
                                        outputDescriptors:(NSArray<MTIRenderPassOutputDescriptor *> *)outputDescriptors;

@end

@protocol MTIRenderPassOutputDescriptorJSSupport <JSExport>

@property (nonatomic,readonly) MTITextureDimensions dimensions;

@property (nonatomic,readonly) MTLPixelFormat pixelFormat;

@property (nonatomic,readonly) MTLLoadAction loadAction;

@property (nonatomic,readonly) MTLStoreAction storeAction;

+ (instancetype)renderPassOutputDescriptorWithSize:(CGSize)size pixelFormat:(MTLPixelFormat)pixelFormat;

+ (instancetype)renderPassOutputDescriptorWithSize:(CGSize)size pixelFormat:(MTLPixelFormat)pixelFormat loadAction:(MTLLoadAction)loadAction;

+ (instancetype)renderPassOutputDescriptorWithDimensions:(MTITextureDimensions)dimensions pixelFormat:(MTLPixelFormat)pixelFormat loadAction:(MTLLoadAction)loadAction storeAction:(MTLStoreAction)storeAction;

@end

@interface MTIRenderCommand (JSSupport) <MTIRenderCommandJSSupport>

@end

@interface MTIRenderPassOutputDescriptor (JSSupport) <MTIRenderPassOutputDescriptorJSSupport>

@end

NS_ASSUME_NONNULL_END
