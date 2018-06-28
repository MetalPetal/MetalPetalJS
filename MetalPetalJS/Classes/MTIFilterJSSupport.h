//
//  MTIFilterJSSupport.h
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>
#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTIFilterJSInitializing <NSObject>

- (nullable instancetype)initWithOptions:(NSDictionary *)options;

@end

@interface MTIBlendFilter (MTIFilterCreationOptions) <MTIFilterJSInitializing>

@end

@protocol MTIFilterJSSupport <JSExport>

JSExportAs(filterWithName,
+ (nullable instancetype)filterWithName:(NSString *)name options:(nullable NSDictionary *)options);

- (nullable id)valueForPropertyKey:(NSString *)key;

- (BOOL)setValue:(nullable id)value forPropertyKey:(NSString *)key;

@end

@interface MTIFilterJSSupport: NSObject

+ (void)exportToContext:(JSContext *)context;

@end


NS_ASSUME_NONNULL_END
