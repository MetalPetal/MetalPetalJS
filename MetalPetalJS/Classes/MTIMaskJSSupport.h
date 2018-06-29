//
//  MTIMaskJSSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/29.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>
#import <MetalPetal/MetalPetal.h>

@protocol MTIMaskJSSupport <JSExport>

@property (nonatomic, strong, readonly) MTIImage *content;

@property (nonatomic, readonly) MTIColorComponent component;

@property (nonatomic, readonly) MTIMaskMode mode;

+ (instancetype)maskWithContent:(MTIImage *)content component:(MTIColorComponent)component mode:(MTIMaskMode)mode;

@end

@interface MTIMask (JSSupport) <MTIMaskJSSupport>

@end

