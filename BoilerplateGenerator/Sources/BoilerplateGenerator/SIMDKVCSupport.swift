import Foundation
import SIMDType

extension SIMDType {
    var mtiSIMDTypeName: String {
        switch self.dimension {
        case .vector(let c):
            return "MTISIMDType\(self.scalarType.description(capitalized: true))\(c)"
        case .matrix(let c, let r):
            return "MTISIMDType\(self.scalarType.description(capitalized: true))\(c)x\(r)"
        }
    }
}

extension SIMDType {
    
    var getterForMTIVector: String {
        switch self.dimension {
        case .vector(let c):
            return "\(self.scalarType.description(capitalized: false))\(c)Value"
        case .matrix(let c, let r):
            return "\(self.scalarType.description(capitalized: false))\(c)x\(r)Value"
        }
    }
    
    var initializerForMTIVector: String {
        switch self.dimension {
        case .vector(let c):
            return "vectorWith\(self.scalarType.description(capitalized: true))\(c):"
        case .matrix(let c, let r):
            return "vectorWith\(self.scalarType.description(capitalized: true))\(c)x\(r):"
        }
    }
}


struct SIMDTypeKVCSupportCodeGenerator {

    struct HeaderTemplate {
        private let template =
        """
        //
        //  MTISIMDTypeKVCSupport.h
        //  MetalPetalJS
        //
        //  Created by Yu Ao on 2018/6/25.
        //
        //  Auto generated.

        #import <Foundation/Foundation.h>
        #import <MetalPetal/MetalPetal.h>
        #import <JavascriptCore/JavascriptCore.h>

        NS_ASSUME_NONNULL_BEGIN

        typedef NS_ENUM(NSUInteger, MTISIMDType) {
            {MTISIMDTYPES}
        };

        FOUNDATION_EXPORT void MTISIMDTypeExportToJSContext(JSContext *context);

        FOUNDATION_EXPORT void MTISetSIMDValueForKey(id object, NSString *key, MTIVector *value, MTISIMDType type);

        FOUNDATION_EXPORT MTIVector * MTIGetSIMDValueForKey(id object, NSString *key, MTISIMDType type);

        NS_ASSUME_NONNULL_END
        """

        private var types: [String] = []

        mutating func append(type: SIMDType) {
            self.types.append(type.mtiSIMDTypeName)
        }

        func makeContent() -> String {
            return self.template.replacingOccurrences(of: "{MTISIMDTYPES}", with: self.types.reduce("", {
                $0.count > 0 ? ($0 + ",\n    " + $1) : $1
            }))
        }
    }

    struct ImplementationTemplate {
        private let template =
        """
        //
        //  MTISIMDTypeKVCSupport.m
        //  MetalPetalJS
        //
        //  Created by Yu Ao on 2018/6/25.
        //
        //  Auto generated.

        #import "MTISIMDTypeKVCSupport.h"
        @import ObjectiveC;

        FOUNDATION_EXPORT void MTISIMDTypeExportToJSContext(JSContext *context) {
            [context setObject:@{
        {SIMDTYPE_JS_EXPORT}
                                }
             forKeyedSubscript:@"MTISIMDType"];
        }

        void MTISetSIMDValueForKey(id object, NSString *key, MTIVector *value, MTISIMDType type) {
            NSCParameterAssert(key.length > 0);
            SEL selector = NSSelectorFromString([[[@"set" stringByAppendingString:[[key substringToIndex:1] uppercaseString]] stringByAppendingString:[key substringFromIndex:1]] stringByAppendingString:@":"]);
            switch (type) {
        {SIMD_VALUE_SET}
                default: {
                    NSCAssert(NO, @"");
                } break;
            }
        }

        MTIVector * MTIGetSIMDValueForKey(id object, NSString *key, MTISIMDType type) {
            NSCParameterAssert(key.length > 0);
            SEL selector = NSSelectorFromString(key);
            switch (type) {
        {SIMD_VALUE_GET}
                default: {
                    NSCAssert(NO, @"");
                } break;
            }
            return nil;
        }
        """

        private var getters: String = ""
        private var setters: String = ""
        private var exports: String = ""

        mutating func append(type: SIMDType) {
            self.exports.append("""
                                    @"\(type.description(prefix:""))": @(\(type.mtiSIMDTypeName)),\n
            """)

            self.setters.append(
                """
                        case \(type.mtiSIMDTypeName): {
                            typedef void (*msgSendType)(id, SEL, \(type.description()));
                            ((msgSendType)objc_msgSend)(object, selector, [value \(type.getterForMTIVector)]);
                        } break;

                """)

            self.getters.append(
                """
                        case \(type.mtiSIMDTypeName): {
                            typedef \(type.description()) (*msgSendType)(id, SEL);
                            \(type.description()) v = ((msgSendType)objc_msgSend)(object, selector);
                            return [MTIVector \(type.initializerForMTIVector)v];
                        } break;

                """)
        }

        func makeContent() -> String {
            var c = self.template.replacingOccurrences(of: "{SIMD_VALUE_SET}", with: self.setters)
            c = c.replacingOccurrences(of: "{SIMD_VALUE_GET}", with: self.getters)
            c = c.replacingOccurrences(of: "{SIMDTYPE_JS_EXPORT}", with: self.exports)
            return c
        }
    }
    
    public static func generate() -> [String: String] {
        var headerTemplate = HeaderTemplate()
        var implementationTemplate = ImplementationTemplate()
        for type in SIMDType.metalSupportedSIMDTypes {
            headerTemplate.append(type: type)
            implementationTemplate.append(type: type)
        }
        return [
            "MTISIMDTypeKVCSupport.h": headerTemplate.makeContent(),
            "MTISIMDTypeKVCSupport.m": implementationTemplate.makeContent()
        ]
    }
}

