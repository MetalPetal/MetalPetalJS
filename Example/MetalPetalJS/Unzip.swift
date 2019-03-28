//
//  Unzip.swift
//  MetalPetalJS_Example
//
//  Created by Yu Ao on 2019/3/28.
//  Copyright © 2019 yuao. All rights reserved.
//

import Foundation
import ZIPFoundation

@objc public class Unzip: NSObject {
    
    private override init() {
        super.init()
    }
    
    @objc(unzipFileAtURL:toURL:error:) public static func unzip(_ file: URL, to url: URL) throws {
        try FileManager().unzipItem(at: file, to: url)
    }
}
