#!/usr/bin/env xcrun swift

//https://github.com/apple/swift/blob/master/stdlib/public/SDK/simd/simd.swift.gyb

import Foundation

struct SIMDType {

    enum ScalarType {
        case `float`
        case `double`
        case `int`
        case `uint`

        static let allCases: [ScalarType] = [.float, .double, .int, .uint]

        var description: String {
            switch self {
            case .int:
                return "int"
            case .float:
                return "float"
            case .double:
                return "double"
            case .uint:
                return "uint"
            }
        }

        var capitalizedDescription: String {
            switch self {
            case .int:
                return "Int"
            case .float:
                return "Float"
            case .double:
                return "Double"
            case .uint:
                return "UInt"
            }
        }
    }

    static let scalarTypes = ScalarType.allCases
    static let cardinal = [2, 3, 4]
    static let prefix = "simd_"

    enum SubType {
        case vector(Int)
        case matrix(Int, Int)
    }

    let scalarType: ScalarType

    let subType: SubType

    var description: String {
        switch self.subType {
        case .vector(let c):
            return "\(SIMDType.prefix)\(self.scalarType.description)\(c)"
        case .matrix(let c, let r):
            return "\(SIMDType.prefix)\(self.scalarType.description)\(c)x\(r)"
        }
    }

    func description(prefix: String) -> String {
        switch self.subType {
        case .vector(let c):
            return "\(prefix)\(self.scalarType.description)\(c)"
        case .matrix(let c, let r):
            return "\(prefix)\(self.scalarType.description)\(c)x\(r)"
        }
    }

    var descriptionForMTISIMDType: String {
        switch self.subType {
        case .vector(let c):
            return "MTISIMDType\(self.scalarType.capitalizedDescription)\(c)"
        case .matrix(let c, let r):
            return "MTISIMDType\(self.scalarType.capitalizedDescription)\(c)x\(r)"
        }
    }

    var getterForMTIVector: String {
        switch self.subType {
        case .vector(let c):
            return "\(self.scalarType.description)\(c)Value"
        case .matrix(let c, let r):
            return "\(self.scalarType.description)\(c)x\(r)Value"
        }
    }

    var initializerForMTIVector: String {
        switch self.subType {
        case .vector(let c):
            return "vectorWith\(self.scalarType.capitalizedDescription)\(c):"
        case .matrix(let c, let r):
            return "vectorWith\(self.scalarType.capitalizedDescription)\(c)x\(r):"
        }

    }

    struct Enumerator: Sequence, IteratorProtocol {
        typealias Element = SIMDType

        private var currentScalarTypeIndex: Int = 0
        private var currentCardinalAIndex: Int = 0
        private var currentCardinalBIndex: Int = 0
        private var currentCardinalIndex: Int = 0

        mutating func next() -> SIMDType? {
            if self.currentCardinalIndex >= 0 {
                let scalarType = SIMDType.scalarTypes[self.currentScalarTypeIndex]
                let currentCardinal = SIMDType.cardinal[self.currentCardinalIndex];

                if self.currentCardinalIndex == SIMDType.cardinal.count - 1 {
                    if self.currentScalarTypeIndex == SIMDType.scalarTypes.count - 1 {
                        self.currentCardinalIndex = -1
                        self.currentScalarTypeIndex = 0
                    } else {
                        self.currentCardinalIndex = 0
                        self.currentScalarTypeIndex += 1
                    }
                } else {
                    self.currentCardinalIndex += 1
                }

                return SIMDType(scalarType: scalarType, subType: .vector(currentCardinal))
            }

            if self.currentScalarTypeIndex >= 0 {
                let scalarType = SIMDType.scalarTypes[self.currentScalarTypeIndex]
                let currentCardinalA = SIMDType.cardinal[self.currentCardinalAIndex];
                let currentCardinalB = SIMDType.cardinal[self.currentCardinalBIndex];

                if self.currentCardinalBIndex == SIMDType.cardinal.count - 1 {
                    if self.currentCardinalAIndex == SIMDType.cardinal.count - 1 {
                        if self.currentScalarTypeIndex == SIMDType.scalarTypes.count - 1 {
                            self.currentScalarTypeIndex = -1
                        } else {
                            self.currentCardinalAIndex = 0
                            self.currentCardinalBIndex = 0
                            self.currentScalarTypeIndex += 1
                        }
                    } else {
                        self.currentCardinalBIndex = 0
                        self.currentCardinalAIndex += 1
                    }
                } else {
                    self.currentCardinalBIndex += 1
                }

                return SIMDType(scalarType: scalarType, subType: .matrix(currentCardinalA, currentCardinalB))
            }

            return nil
        }

    }
}

extension SIMDType: Equatable {
    static func == (lhs: SIMDType, rhs: SIMDType) -> Bool {
        if lhs.scalarType == rhs.scalarType {
            switch lhs.subType {
            case .vector(let c):
                switch rhs.subType {
                case .vector(let c2):
                    return c == c2
                default:
                    return false
                }
            case .matrix(let c, let r):
                switch rhs.subType {
                case .matrix(let c2, let r2):
                    return c == c2 && r == r2
                default:
                    return false
                }
            }
        }
        return false
    }
}

struct SIMDTypeKVCSupportGenerator {

    struct HeaderTemplate {
        private let template =
        """
        //
        //  MTISIMDTypeKVCSupport.h
        //  MetalPetalJS
        //
        //  Created by Yu Ao on 2018/6/25.
        //
        //  Auto generated by generate-simd-kvc-support.sh

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
            self.types.append(type.descriptionForMTISIMDType)
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
        //  Auto generated by generate-simd-kvc-support.sh

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

        private let MTIVectorSupportedType = [SIMDType(scalarType: .float, subType: .vector(2)),
                                              SIMDType(scalarType: .float, subType: .vector(3)),
                                              SIMDType(scalarType: .float, subType: .vector(4)),
                                              SIMDType(scalarType: .float, subType: .matrix(4, 4))]

        mutating func append(type: SIMDType) {
            self.exports.append("""
                                    @"\(type.description(prefix:""))": @(\(type.descriptionForMTISIMDType)),\n
            """)

            if !MTIVectorSupportedType.contains(type) {
                return
            }

            self.setters.append(
                """
                        case \(type.descriptionForMTISIMDType): {
                            typedef void (*msgSendType)(id, SEL, \(type.description));
                            ((msgSendType)objc_msgSend)(object, selector, [value \(type.getterForMTIVector)]);
                        } break;

                """)

            self.getters.append(
                """
                        case \(type.descriptionForMTISIMDType): {
                            typedef \(type.description) (*msgSendType)(id, SEL);
                            \(type.description) v = ((msgSendType)objc_msgSend)(object, selector);
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

    static func run() {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let scriptURL: URL
        if CommandLine.arguments[0].hasPrefix("/") {
            scriptURL = URL(fileURLWithPath: CommandLine.arguments[0])
        } else {
            scriptURL = currentDirectoryURL.appendingPathComponent(CommandLine.arguments[0])
        }
        let directoryURL = scriptURL.deletingLastPathComponent()
        let headerFileURL = directoryURL.appendingPathComponent("../Classes/MTISIMDTypeKVCSupport.h")
        let implementationFileURL = directoryURL.appendingPathComponent("../Classes/MTISIMDTypeKVCSupport.m")

        var headerTemplate = HeaderTemplate()
        var implementationTemplate = ImplementationTemplate()
        for type in SIMDType.Enumerator() {
            headerTemplate.append(type: type)
            implementationTemplate.append(type: type)
        }

        try! headerTemplate.makeContent().write(to: headerFileURL, atomically: true, encoding: .utf8)
        try! implementationTemplate.makeContent().write(to: implementationFileURL, atomically: true, encoding: .utf8)

        print("Done!")
    }
}

SIMDTypeKVCSupportGenerator.run()

