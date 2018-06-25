//
//  MTISIMDTypeKVCSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import <Foundation/Foundation.h>
#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MTISIMDType) {
    MTISIMDTypeFloat2,
    MTISIMDTypeFloat3
};

FOUNDATION_EXPORT void MTISIMDTypeKVCSetSIMDData(id object, NSString *key, NSData *data, MTISIMDType type);

FOUNDATION_EXPORT NSData * MTISIMDTypeKVCGetSIMDData(id object, NSString *key, MTISIMDType type);

FOUNDATION_EXPORT void MTISIMDTypeKVCSetSIMDValue(id object, NSString *key, MTIVector *data, MTISIMDType type);

FOUNDATION_EXPORT MTIVector * MTISIMDTypeKVCGetSIMDValue(id object, NSString *key, MTISIMDType type);


NS_ASSUME_NONNULL_END
