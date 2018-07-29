//
//  MTISIMDTypeKVCSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//
//  Auto generated.

#import "MTISIMDTypeKVCSupport.h"
@import ObjectiveC;

FOUNDATION_EXPORT void MTISIMDTypeExportToJSContext(JSContext *context) {
    [context setObject:@{
                        @"float2": @(MTISIMDTypeFloat2),
                        @"float3": @(MTISIMDTypeFloat3),
                        @"float4": @(MTISIMDTypeFloat4),
                        @"float8": @(MTISIMDTypeFloat8),
                        @"float16": @(MTISIMDTypeFloat16),
                        @"float2x2": @(MTISIMDTypeFloat2x2),
                        @"float2x3": @(MTISIMDTypeFloat2x3),
                        @"float2x4": @(MTISIMDTypeFloat2x4),
                        @"float3x2": @(MTISIMDTypeFloat3x2),
                        @"float3x3": @(MTISIMDTypeFloat3x3),
                        @"float3x4": @(MTISIMDTypeFloat3x4),
                        @"float4x2": @(MTISIMDTypeFloat4x2),
                        @"float4x3": @(MTISIMDTypeFloat4x3),
                        @"float4x4": @(MTISIMDTypeFloat4x4),
                        @"int2": @(MTISIMDTypeInt2),
                        @"int3": @(MTISIMDTypeInt3),
                        @"int4": @(MTISIMDTypeInt4),
                        @"int8": @(MTISIMDTypeInt8),
                        @"int16": @(MTISIMDTypeInt16),
                        @"uint2": @(MTISIMDTypeUInt2),
                        @"uint3": @(MTISIMDTypeUInt3),
                        @"uint4": @(MTISIMDTypeUInt4),
                        @"uint8": @(MTISIMDTypeUInt8),
                        @"uint16": @(MTISIMDTypeUInt16),

                        }
     forKeyedSubscript:@"MTISIMDType"];
}

void MTISetSIMDValueForKey(id object, NSString *key, MTIVector *value, MTISIMDType type) {
    NSCParameterAssert(key.length > 0);
    SEL selector = NSSelectorFromString([[[@"set" stringByAppendingString:[[key substringToIndex:1] uppercaseString]] stringByAppendingString:[key substringFromIndex:1]] stringByAppendingString:@":"]);
    switch (type) {
        case MTISIMDTypeFloat2: {
            typedef void (*msgSendType)(id, SEL, simd_float2);
            ((msgSendType)objc_msgSend)(object, selector, [value float2Value]);
        } break;
        case MTISIMDTypeFloat3: {
            typedef void (*msgSendType)(id, SEL, simd_float3);
            ((msgSendType)objc_msgSend)(object, selector, [value float3Value]);
        } break;
        case MTISIMDTypeFloat4: {
            typedef void (*msgSendType)(id, SEL, simd_float4);
            ((msgSendType)objc_msgSend)(object, selector, [value float4Value]);
        } break;
        case MTISIMDTypeFloat8: {
            typedef void (*msgSendType)(id, SEL, simd_float8);
            ((msgSendType)objc_msgSend)(object, selector, [value float8Value]);
        } break;
        case MTISIMDTypeFloat16: {
            typedef void (*msgSendType)(id, SEL, simd_float16);
            ((msgSendType)objc_msgSend)(object, selector, [value float16Value]);
        } break;
        case MTISIMDTypeFloat2x2: {
            typedef void (*msgSendType)(id, SEL, simd_float2x2);
            ((msgSendType)objc_msgSend)(object, selector, [value float2x2Value]);
        } break;
        case MTISIMDTypeFloat2x3: {
            typedef void (*msgSendType)(id, SEL, simd_float2x3);
            ((msgSendType)objc_msgSend)(object, selector, [value float2x3Value]);
        } break;
        case MTISIMDTypeFloat2x4: {
            typedef void (*msgSendType)(id, SEL, simd_float2x4);
            ((msgSendType)objc_msgSend)(object, selector, [value float2x4Value]);
        } break;
        case MTISIMDTypeFloat3x2: {
            typedef void (*msgSendType)(id, SEL, simd_float3x2);
            ((msgSendType)objc_msgSend)(object, selector, [value float3x2Value]);
        } break;
        case MTISIMDTypeFloat3x3: {
            typedef void (*msgSendType)(id, SEL, simd_float3x3);
            ((msgSendType)objc_msgSend)(object, selector, [value float3x3Value]);
        } break;
        case MTISIMDTypeFloat3x4: {
            typedef void (*msgSendType)(id, SEL, simd_float3x4);
            ((msgSendType)objc_msgSend)(object, selector, [value float3x4Value]);
        } break;
        case MTISIMDTypeFloat4x2: {
            typedef void (*msgSendType)(id, SEL, simd_float4x2);
            ((msgSendType)objc_msgSend)(object, selector, [value float4x2Value]);
        } break;
        case MTISIMDTypeFloat4x3: {
            typedef void (*msgSendType)(id, SEL, simd_float4x3);
            ((msgSendType)objc_msgSend)(object, selector, [value float4x3Value]);
        } break;
        case MTISIMDTypeFloat4x4: {
            typedef void (*msgSendType)(id, SEL, simd_float4x4);
            ((msgSendType)objc_msgSend)(object, selector, [value float4x4Value]);
        } break;
        case MTISIMDTypeInt2: {
            typedef void (*msgSendType)(id, SEL, simd_int2);
            ((msgSendType)objc_msgSend)(object, selector, [value int2Value]);
        } break;
        case MTISIMDTypeInt3: {
            typedef void (*msgSendType)(id, SEL, simd_int3);
            ((msgSendType)objc_msgSend)(object, selector, [value int3Value]);
        } break;
        case MTISIMDTypeInt4: {
            typedef void (*msgSendType)(id, SEL, simd_int4);
            ((msgSendType)objc_msgSend)(object, selector, [value int4Value]);
        } break;
        case MTISIMDTypeInt8: {
            typedef void (*msgSendType)(id, SEL, simd_int8);
            ((msgSendType)objc_msgSend)(object, selector, [value int8Value]);
        } break;
        case MTISIMDTypeInt16: {
            typedef void (*msgSendType)(id, SEL, simd_int16);
            ((msgSendType)objc_msgSend)(object, selector, [value int16Value]);
        } break;
        case MTISIMDTypeUInt2: {
            typedef void (*msgSendType)(id, SEL, simd_uint2);
            ((msgSendType)objc_msgSend)(object, selector, [value uint2Value]);
        } break;
        case MTISIMDTypeUInt3: {
            typedef void (*msgSendType)(id, SEL, simd_uint3);
            ((msgSendType)objc_msgSend)(object, selector, [value uint3Value]);
        } break;
        case MTISIMDTypeUInt4: {
            typedef void (*msgSendType)(id, SEL, simd_uint4);
            ((msgSendType)objc_msgSend)(object, selector, [value uint4Value]);
        } break;
        case MTISIMDTypeUInt8: {
            typedef void (*msgSendType)(id, SEL, simd_uint8);
            ((msgSendType)objc_msgSend)(object, selector, [value uint8Value]);
        } break;
        case MTISIMDTypeUInt16: {
            typedef void (*msgSendType)(id, SEL, simd_uint16);
            ((msgSendType)objc_msgSend)(object, selector, [value uint16Value]);
        } break;

        default: {
            NSCAssert(NO, @"");
        } break;
    }
}

MTIVector * MTIGetSIMDValueForKey(id object, NSString *key, MTISIMDType type) {
    NSCParameterAssert(key.length > 0);
    SEL selector = NSSelectorFromString(key);
    switch (type) {
        case MTISIMDTypeFloat2: {
            typedef simd_float2 (*msgSendType)(id, SEL);
            simd_float2 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat2:v];
        } break;
        case MTISIMDTypeFloat3: {
            typedef simd_float3 (*msgSendType)(id, SEL);
            simd_float3 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat3:v];
        } break;
        case MTISIMDTypeFloat4: {
            typedef simd_float4 (*msgSendType)(id, SEL);
            simd_float4 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat4:v];
        } break;
        case MTISIMDTypeFloat8: {
            typedef simd_float8 (*msgSendType)(id, SEL);
            simd_float8 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat8:v];
        } break;
        case MTISIMDTypeFloat16: {
            typedef simd_float16 (*msgSendType)(id, SEL);
            simd_float16 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat16:v];
        } break;
        case MTISIMDTypeFloat2x2: {
            typedef simd_float2x2 (*msgSendType)(id, SEL);
            simd_float2x2 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat2x2:v];
        } break;
        case MTISIMDTypeFloat2x3: {
            typedef simd_float2x3 (*msgSendType)(id, SEL);
            simd_float2x3 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat2x3:v];
        } break;
        case MTISIMDTypeFloat2x4: {
            typedef simd_float2x4 (*msgSendType)(id, SEL);
            simd_float2x4 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat2x4:v];
        } break;
        case MTISIMDTypeFloat3x2: {
            typedef simd_float3x2 (*msgSendType)(id, SEL);
            simd_float3x2 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat3x2:v];
        } break;
        case MTISIMDTypeFloat3x3: {
            typedef simd_float3x3 (*msgSendType)(id, SEL);
            simd_float3x3 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat3x3:v];
        } break;
        case MTISIMDTypeFloat3x4: {
            typedef simd_float3x4 (*msgSendType)(id, SEL);
            simd_float3x4 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat3x4:v];
        } break;
        case MTISIMDTypeFloat4x2: {
            typedef simd_float4x2 (*msgSendType)(id, SEL);
            simd_float4x2 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat4x2:v];
        } break;
        case MTISIMDTypeFloat4x3: {
            typedef simd_float4x3 (*msgSendType)(id, SEL);
            simd_float4x3 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat4x3:v];
        } break;
        case MTISIMDTypeFloat4x4: {
            typedef simd_float4x4 (*msgSendType)(id, SEL);
            simd_float4x4 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithFloat4x4:v];
        } break;
        case MTISIMDTypeInt2: {
            typedef simd_int2 (*msgSendType)(id, SEL);
            simd_int2 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithInt2:v];
        } break;
        case MTISIMDTypeInt3: {
            typedef simd_int3 (*msgSendType)(id, SEL);
            simd_int3 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithInt3:v];
        } break;
        case MTISIMDTypeInt4: {
            typedef simd_int4 (*msgSendType)(id, SEL);
            simd_int4 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithInt4:v];
        } break;
        case MTISIMDTypeInt8: {
            typedef simd_int8 (*msgSendType)(id, SEL);
            simd_int8 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithInt8:v];
        } break;
        case MTISIMDTypeInt16: {
            typedef simd_int16 (*msgSendType)(id, SEL);
            simd_int16 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithInt16:v];
        } break;
        case MTISIMDTypeUInt2: {
            typedef simd_uint2 (*msgSendType)(id, SEL);
            simd_uint2 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithUInt2:v];
        } break;
        case MTISIMDTypeUInt3: {
            typedef simd_uint3 (*msgSendType)(id, SEL);
            simd_uint3 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithUInt3:v];
        } break;
        case MTISIMDTypeUInt4: {
            typedef simd_uint4 (*msgSendType)(id, SEL);
            simd_uint4 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithUInt4:v];
        } break;
        case MTISIMDTypeUInt8: {
            typedef simd_uint8 (*msgSendType)(id, SEL);
            simd_uint8 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithUInt8:v];
        } break;
        case MTISIMDTypeUInt16: {
            typedef simd_uint16 (*msgSendType)(id, SEL);
            simd_uint16 v = ((msgSendType)objc_msgSend)(object, selector);
            return [MTIVector vectorWithUInt16:v];
        } break;

        default: {
            NSCAssert(NO, @"");
        } break;
    }
    return nil;
}