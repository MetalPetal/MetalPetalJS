//
//  MTILayerJSSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/29.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>
#import <MetalPetal/MetalPetal.h>

@protocol MTILayerJSSupport <JSExport>

@property (nonatomic, strong, readonly) MTIImage *content;

@property (nonatomic, readonly) BOOL contentIsFlipped;

@property (nonatomic, readonly) CGRect contentRegion; //pixel

@property (nonatomic, strong, readonly, nullable) MTIMask *compositingMask;

@property (nonatomic, readonly) MTILayerLayoutUnit layoutUnit;

@property (nonatomic, readonly) CGPoint position;

@property (nonatomic, readonly) CGSize size;

@property (nonatomic, readonly) float rotation; //rad

@property (nonatomic, readonly) float opacity;

@property (nonatomic, copy, readonly) MTIBlendMode blendMode;

- (CGSize)sizeInPixelForBackgroundSize:(CGSize)backgroundSize;

- (CGPoint)positionInPixelForBackgroundSize:(CGSize)backgroundSize;

+ (instancetype)layerWithContent:(MTIImage *)content
                contentIsFlipped:(BOOL)contentIsFlipped
                   contentRegion:(CGRect)contentRegion
                       blendMode:(MTIBlendMode)blendMode
                 compositingMask:(MTIMask *)compositingMask
                      layoutUnit:(MTILayerLayoutUnit)layoutUnit
                        position:(CGPoint)position
                            size:(CGSize)size
                        rotation:(float)rotation
                         opacity:(float)opacity;

@end

@interface MTILayer (JSSupport) <MTILayerJSSupport>

@end
