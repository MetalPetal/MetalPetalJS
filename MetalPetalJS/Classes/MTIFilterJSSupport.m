//
//  MTIFilterJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIFilterJSSupport.h"

@interface MTIJSNativeFilter: NSObject <MTIFilterJSSupport>

@property (nonatomic, strong) id filter;

@end

@implementation MTIJSNativeFilter

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _filter = [[NSClassFromString(name) alloc] init];
        if (!_filter) {
            return nil;
        }
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [_filter setValue:value forKey:key];
}

- (id)valueForKey:(NSString *)key {
    return [_filter valueForKey:key];
}

+ (nullable instancetype)filterWithName:(nonnull NSString *)name {
    return [[self alloc] initWithName:name];
}

@end


@implementation MTIFilterJSSupport

+ (void)exportToContext:(JSContext *)context {
    [context setObject:MTIJSNativeFilter.class forKeyedSubscript:@"MTINativeFilter"];
}

@end
