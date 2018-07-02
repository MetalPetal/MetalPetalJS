//
//  MTIVectorJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIVectorJSSupport.h"

@implementation MTIVector (JSSupport)

+ (instancetype)vectorWithFloatValues:(NSArray<NSNumber *> *)values {
    float v[values.count];
    NSUInteger index = 0;
    for (NSNumber *value in values) {
        v[index] = [value floatValue];
        index += 1;
    }
    return [MTIVector vectorWithFloatValues:v count:values.count];
}

+ (instancetype)vectorWithIntValues:(NSArray<NSNumber *> *)values {
    int v[values.count];
    NSUInteger index = 0;
    for (NSNumber *value in values) {
        v[index] = [value intValue];
        index += 1;
    }
    return [MTIVector vectorWithIntValues:v count:values.count];
}

+ (instancetype)vectorWithUIntValues:(NSArray<NSNumber *> *)values {
    unsigned int v[values.count];
    NSUInteger index = 0;
    for (NSNumber *value in values) {
        v[index] = [value unsignedIntValue];
        index += 1;
    }
    return [MTIVector vectorWithUIntValues:v count:values.count];
}

@end
