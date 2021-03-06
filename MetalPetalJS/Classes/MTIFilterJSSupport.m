//
//  MTIFilterJSSupport.m
//  MetalPetalJS
//
//  Created by Yu Ao on 2018/6/25.
//

#import "MTIFilterJSSupport.h"
#import "MTISIMDTypeKVCSupport.h"

@implementation MTIBlendFilter (MTIFilterCreationOptions)

- (instancetype)initWithOptions:(NSDictionary *)options {
    MTIBlendMode blendMode = options[@"blendMode"];
    NSParameterAssert(blendMode.length > 0);
    return [self initWithBlendMode:blendMode];
}

@end

static BOOL MTIJSNativeFilterParseSIMDTypeInfo(NSString *input, NSString **key, MTISIMDType *type) {
    NSArray *components = [input componentsSeparatedByString:@"$"];
    NSCParameterAssert(components.count == 2);
    if (components.count != 2) {
        return NO;
    }
    
    NSString *simdType = components.lastObject;
    MTISIMDType t = MTISIMDTypeFromString(simdType);
    
    NSCAssert(t != MTISIMDTypeUnknown, @"");
    
    if (t == MTISIMDTypeUnknown) {
        return NO;
    }
    
    *key = components.firstObject;
    *type = t;
    
    return YES;
}

@interface MTIJSNativeFilter: NSObject <MTIFilterJSSupport>

@property (nonatomic, strong) id filter;

@end

@implementation MTIJSNativeFilter

- (instancetype)initWithName:(NSString *)name options:(NSDictionary *)options {
    if (self = [super init]) {
        Class FilterClass = NSClassFromString(name);
        if ([FilterClass conformsToProtocol:@protocol(MTIFilterJSInitializing)]) {
            _filter = [(id<MTIFilterJSInitializing>)[FilterClass alloc] initWithOptions:options];
        } else {
            _filter = [[FilterClass alloc] init];
        }
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
    
    if ([key containsString:@"$"]) {
        NSString *k = nil;
        MTISIMDType t = MTISIMDTypeUnknown;
        if (MTIJSNativeFilterParseSIMDTypeInfo(key, &k, &t)) {
            MTISetSIMDValueForKey(self.filter, k, value, t);
            return YES;
        }
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
    
    if ([key containsString:@"$"]) {
        NSString *k = nil;
        MTISIMDType t = MTISIMDTypeUnknown;
        if (MTIJSNativeFilterParseSIMDTypeInfo(key, &k, &t)) {
            return MTIGetSIMDValueForKey(self.filter, k, t);
        }
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

+ (nullable instancetype)filterWithName:(nonnull NSString *)name options:(nullable NSDictionary *)options {
    return [[self alloc] initWithName:name options:options];
}

@end

@implementation MTIFilterJSSupport

+ (void)exportToContext:(JSContext *)context {
    [context setObject:MTIJSNativeFilter.class forKeyedSubscript:NSStringFromClass(MTIJSNativeFilter.class)];
}

@end
