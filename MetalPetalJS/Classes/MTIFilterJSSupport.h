//
//  MTIFilterJSSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTIFilterJSSupport <JSExport>

+ (nullable instancetype)filterWithName:(NSString *)name;

- (nullable id)valueForPropertyKey:(NSString *)key;

- (BOOL)setValue:(nullable id)value forPropertyKey:(NSString *)key;

@end

@interface MTIFilterJSSupport: NSObject

+ (void)exportToContext:(JSContext *)context;

@end


NS_ASSUME_NONNULL_END
