//
//  MTIKernelJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIKernelJSSupport.h"

static MTIFunctionDescriptor *MTIFunctionDescriptorFrom(NSDictionary *JSONObject, NSString *key){
    NSDictionary *functionDescriptor = JSONObject[key];
    NSString *name = functionDescriptor[@"name"];
    NSCParameterAssert(name);
    if (name.length) {
        NSURL *libraryURL = functionDescriptor[@"library"];
        if (libraryURL) {
            return [[MTIFunctionDescriptor alloc] initWithName:name libraryURL:libraryURL];
        } else {
            return [[MTIFunctionDescriptor alloc] initWithName:name];
        }
    }
    return nil;
}

static MTIAlphaTypeHandlingRule *MTIAlphaTypeHandlingRuleFrom(NSDictionary *JSONObject) {
    MTIAlphaTypeHandlingRule *rule = MTIAlphaTypeHandlingRule.generalAlphaTypeHandlingRule;
    NSDictionary *alphaRuleDescriptor = JSONObject[@"alphaRule"];
    if (alphaRuleDescriptor) {
        rule = [[MTIAlphaTypeHandlingRule alloc] initWithAcceptableAlphaTypes:alphaRuleDescriptor[@"accept"] outputAlphaType:[alphaRuleDescriptor[@"output"] integerValue]];
    }
    return rule;
}


@implementation MTIRenderPipelineKernel (JSSupport)

+ (nullable instancetype)kernelWithJSONDescriptor:(NSDictionary *)JSONDescriptor {
    NSUInteger colorAttachmentCount = JSONDescriptor[@"colorAttachmentCount"] ? [JSONDescriptor[@"colorAttachmentCount"] integerValue] : 1;
    return [[MTIRenderPipelineKernel alloc] initWithVertexFunctionDescriptor:MTIFunctionDescriptorFrom(JSONDescriptor, @"vertexFunction")
                                                  fragmentFunctionDescriptor:MTIFunctionDescriptorFrom(JSONDescriptor, @"fragmentFunction")
                                                            vertexDescriptor:nil
                                                        colorAttachmentCount:colorAttachmentCount
                                                       alphaTypeHandlingRule:MTIAlphaTypeHandlingRuleFrom(JSONDescriptor)];
}

@end

@implementation MTIComputePipelineKernel (JSSupport)

+ (nullable instancetype)kernelWithJSONDescriptor:(NSDictionary *)JSONDescriptor {
    return [[MTIComputePipelineKernel alloc] initWithComputeFunctionDescriptor:MTIFunctionDescriptorFrom(JSONDescriptor, @"computeFunction")
                                                         alphaTypeHandlingRule:MTIAlphaTypeHandlingRuleFrom(JSONDescriptor)];
}

@end

@implementation MTIMPSKernel (JSSupport)

+ (nullable instancetype)kernelWithJSONDescriptor:(NSDictionary *)JSONDescriptor {
    return nil;
}

@end
