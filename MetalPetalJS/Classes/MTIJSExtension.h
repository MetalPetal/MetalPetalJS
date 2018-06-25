//
//  MTIJSExtension.h
//  Pods
//
//  Created by Yu Ao on 2018/6/25.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTIJSExtension : NSObject

+ (void)exportToJSContext:(JSContext *)context;

@end

NS_ASSUME_NONNULL_END
