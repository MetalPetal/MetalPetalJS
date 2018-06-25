#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MTIImageJSSupport.h"
#import "MTIJSExtension.h"
#import "MTISIMDTypeKVCSupport.h"
#import "MTIVectorJSSupport.h"

FOUNDATION_EXPORT double MetalPetalJSVersionNumber;
FOUNDATION_EXPORT const unsigned char MetalPetalJSVersionString[];

