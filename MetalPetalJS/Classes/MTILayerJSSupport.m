//
//  MTILayerJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/29.
//

#import "MTILayerJSSupport.h"

@implementation MTILayer (JSSupport)

+ (instancetype)layerWithContent:(MTIImage *)content contentRegion:(CGRect)contentRegion contentFlipOptions:(MTILayerFlipOptions)contentFlipOptions blendMode:(MTIBlendMode)blendMode compositingMask:(MTIMask *)compositingMask layoutUnit:(MTILayerLayoutUnit)layoutUnit position:(CGPoint)position size:(CGSize)size rotation:(float)rotation opacity:(float)opacity {
    return [[MTILayer alloc] initWithContent:content contentRegion:contentRegion contentFlipOptions:contentFlipOptions compositingMask:compositingMask layoutUnit:layoutUnit position:position size:size rotation:rotation opacity:opacity blendMode:blendMode];
}

@end
