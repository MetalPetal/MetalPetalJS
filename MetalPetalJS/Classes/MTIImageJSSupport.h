//
//  MTIImageJSSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>
#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTIImageJSSupport <JSExport>

@property (nonatomic,readonly) MTIImageCachePolicy cachePolicy;

@property (nonatomic,readonly) CGRect extent;

@property (nonatomic,readonly) CGSize size;

@property (nonatomic,readonly) MTISamplerDescriptor *samplerDescriptor;

@property (nonatomic,readonly) MTIAlphaType alphaType; //relay to underlying promise

- (instancetype)imageWithSamplerDescriptor:(MTISamplerDescriptor *)samplerDescriptor;

- (instancetype)imageWithCachePolicy:(MTIImageCachePolicy)cachePolicy;

+ (nullable instancetype)imageWithContentsOfFile:(NSString *)filePath options:(nullable NSDictionary<MTKTextureLoaderOption,id> *)options alphaType:(MTIAlphaType)alphaType;

+ (nullable instancetype)imageWithContentsOfFile:(NSString *)filePath options:(nullable NSDictionary<MTKTextureLoaderOption,id> *)options;

+ (instancetype)imageWithColor:(MTIColor)color sRGB:(BOOL)sRGB size:(CGSize)size;

@end

@interface MTIImage (JSSupport) <MTIImageJSSupport>

@end

NS_ASSUME_NONNULL_END
