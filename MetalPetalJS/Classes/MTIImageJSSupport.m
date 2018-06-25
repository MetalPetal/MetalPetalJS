//
//  MTIImageJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIImageJSSupport.h"

@implementation MTIImage (JSSupport)

+ (instancetype)imageWithContentsOfFile:(NSString *)filePath options:(NSDictionary<MTKTextureLoaderOption,id> *)options alphaType:(MTIAlphaType)alphaType {
    NSURL *url = [NSURL fileURLWithPath:filePath];
    return [[MTIImage alloc] initWithContentsOfURL:url options:options alphaType:alphaType];
}

@end