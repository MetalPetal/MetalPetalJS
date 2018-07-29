//
//  MTISIMDTypeKVCSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//
//  Auto generated.

#import <Foundation/Foundation.h>
#import <MetalPetal/MetalPetal.h>
#import <JavascriptCore/JavascriptCore.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MTISIMDType) {
    MTISIMDTypeUnknown,
    MTISIMDTypeFloat2,
    MTISIMDTypeFloat3,
    MTISIMDTypeFloat4,
    MTISIMDTypeFloat8,
    MTISIMDTypeFloat16,
    MTISIMDTypeFloat2x2,
    MTISIMDTypeFloat2x3,
    MTISIMDTypeFloat2x4,
    MTISIMDTypeFloat3x2,
    MTISIMDTypeFloat3x3,
    MTISIMDTypeFloat3x4,
    MTISIMDTypeFloat4x2,
    MTISIMDTypeFloat4x3,
    MTISIMDTypeFloat4x4,
    MTISIMDTypeInt2,
    MTISIMDTypeInt3,
    MTISIMDTypeInt4,
    MTISIMDTypeInt8,
    MTISIMDTypeInt16,
    MTISIMDTypeUInt2,
    MTISIMDTypeUInt3,
    MTISIMDTypeUInt4,
    MTISIMDTypeUInt8,
    MTISIMDTypeUInt16
};

FOUNDATION_EXPORT MTISIMDType MTISIMDTypeFromString(NSString *type);

FOUNDATION_EXPORT void MTISIMDTypeKVCSupportExportToJSContext(JSContext *context);

FOUNDATION_EXPORT void MTISetSIMDValueForKey(id object, NSString *key, MTIVector *value, MTISIMDType type);

FOUNDATION_EXPORT MTIVector * MTIGetSIMDValueForKey(id object, NSString *key, MTISIMDType type);

NS_ASSUME_NONNULL_END