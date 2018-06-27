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

- (BOOL)setValue:(id)value forPropertyKey:(NSString *)key {
    if ([key isEqualToString:@"__proto__"]) {
        return NO;
    }
    
    BOOL result = NO;
    @try {
        [_filter setValue:value forKey:key];
        result = YES;
    } @catch (NSException *ex) {
        NSLog(@"*** Caught exception setting key \"%@\" : %@", key, ex);
    }
    return result;
}

- (id)valueForPropertyKey:(NSString *)key {
    if ([key isEqualToString:@"__proto__"]) {
        return nil;
    }
    
    id result = nil;
    @try {
        result = [_filter valueForKey:key];
    } @catch (NSException *ex) {
        NSLog(@"*** Caught exception getting key \"%@\" : %@", key, ex);
    }
    return result;
}

+ (nullable instancetype)filterWithName:(nonnull NSString *)name {
    return [[self alloc] initWithName:name];
}

@end

@implementation MTIFilterJSSupport

+ (void)exportToContext:(JSContext *)context {
    [context setObject:MTIJSNativeFilter.class forKeyedSubscript:NSStringFromClass(MTIJSNativeFilter.class)];
}

@end
