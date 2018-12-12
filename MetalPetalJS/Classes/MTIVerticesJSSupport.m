//
//  MTIVerticesJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIVerticesJSSupport.h"

@implementation MTIVertices (JSSupport)

+ (instancetype)verticesFromJSONDescriptors:(NSArray *)descriptors {
    MTIVertex *vertices = malloc(sizeof(MTIVertex) * descriptors.count);
    for (int index = 0; index < descriptors.count; index++) {
        NSDictionary *descriptor = descriptors[index];
        vertices[index] = (MTIVertex){
            .position = {
                [descriptor[@"position"][@"x"] floatValue],
                [descriptor[@"position"][@"y"] floatValue],
                [descriptor[@"position"][@"z"] floatValue],
                [descriptor[@"position"][@"w"] floatValue]
            }, .textureCoordinate = {
                [descriptor[@"textureCoordinate"][@"x"] floatValue],
                [descriptor[@"textureCoordinate"][@"y"] floatValue]
            }
        };
    }
    MTIVertices *result = [[MTIVertices alloc] initWithVertices:vertices count:descriptors.count primitiveType:MTLPrimitiveTypeTriangleStrip];
    free(vertices);
    return result;
}

@end
