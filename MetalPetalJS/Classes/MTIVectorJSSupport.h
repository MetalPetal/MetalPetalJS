//
//  MTIVectorJSSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>
#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTIVectorJSSupport <JSExport>

+ (instancetype)vectorWithValues:(NSArray<NSNumber *> *)values;

@property (readonly) CGPoint CGPointValue;
@property (readonly) CGSize CGSizeValue;
@property (readonly) CGRect CGRectValue;

@property (readonly) NSUInteger count;

@property (nonatomic,copy,readonly) NSData *data;

@end

@interface MTIVector (JSSupport) <MTIVectorJSSupport>

@end

NS_ASSUME_NONNULL_END
