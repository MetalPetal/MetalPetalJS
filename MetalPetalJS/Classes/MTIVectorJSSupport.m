//
//  MTIVectorJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIVectorJSSupport.h"

@implementation MTIVector (JSSupport)

+ (instancetype)vectorWithValues:(NSArray<NSNumber *> *)values {
    float v[values.count];
    NSUInteger index = 0;
    for (NSNumber *value in values) {
        v[index] = [value floatValue];
        index += 1;
    }
    return [MTIVector vectorWithValues:v count:values.count];
}

@end
