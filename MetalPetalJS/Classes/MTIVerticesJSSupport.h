//
//  MTIVerticesJSSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>
#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTIVerticesJSSupport <JSExport>

+ (instancetype)squareVerticesForRect:(CGRect)rect;

@end

@interface MTIVertices (JSSupport) <MTIVerticesJSSupport>

@end

NS_ASSUME_NONNULL_END
