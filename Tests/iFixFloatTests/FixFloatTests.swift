//
//  FixFloatTests.swift
//
//
//  Created by Nail Sharipov on 12.01.2024.
//

import XCTest
@testable import iFixFloat

final class FixFloatTests: XCTestCase {
    
    func test_0() {
        XCTAssertEqual(FixFloat.fixMax, Int64(Int32.max))
    }
    
    func test_1() {
        XCTAssertEqual(FixFloat.fixMin, Int64(Int32.min))
    }
    
}
