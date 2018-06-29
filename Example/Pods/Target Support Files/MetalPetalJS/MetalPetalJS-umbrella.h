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

#import "MTIFilterJSSupport.h"
#import "MTIImageJSSupport.h"
#import "MTIJSExtension.h"
#import "MTIKernelJSSupport.h"
#import "MTILayerJSSupport.h"
#import "MTIMaskJSSupport.h"
#import "MTIRenderCommandJSSupport.h"
#import "MTISIMDTypeKVCSupport.h"
#import "MTIVectorJSSupport.h"
#import "MTIVerticesJSSupport.h"

FOUNDATION_EXPORT double MetalPetalJSVersionNumber;
FOUNDATION_EXPORT const unsigned char MetalPetalJSVersionString[];

