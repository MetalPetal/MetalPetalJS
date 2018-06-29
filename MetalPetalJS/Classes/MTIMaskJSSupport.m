//
//  MTIMaskJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/29.
//

#import "MTIMaskJSSupport.h"

@implementation MTIMask (JSSupport)

+ (instancetype)maskWithContent:(MTIImage *)content component:(MTIColorComponent)component mode:(MTIMaskMode)mode {
    return [[MTIMask alloc] initWithContent:content component:component mode:mode];
}

@end
