//
//  MTILayerJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/29.
//

#import "MTILayerJSSupport.h"

@implementation MTILayer (JSSupport)

+ (instancetype)layerWithContent:(MTIImage *)content contentIsFlipped:(BOOL)contentIsFlipped contentRegion:(CGRect)contentRegion compositingMask:(MTIMask *)compositingMask layoutUnit:(MTILayerLayoutUnit)layoutUnit position:(CGPoint)position size:(CGSize)size rotation:(float)rotation opacity:(float)opacity blendMode:(MTIBlendMode)blendMode {
    return [[MTILayer alloc] initWithContent:content contentIsFlipped:contentIsFlipped contentRegion:contentRegion compositingMask:compositingMask layoutUnit:layoutUnit position:position size:size rotation:rotation opacity:opacity blendMode:blendMode];
}

@end
