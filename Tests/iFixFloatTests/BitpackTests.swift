//
//  BitpackTests.swift
//
//
//  Created by Nail Sharipov on 20.11.2023.
//

import XCTest
@testable import iFixFloat

final class BitpackTests: XCTestCase {
    
    func test_0() {
        XCTAssert(FixVec(0, 0).bitPack < FixVec(0, 1).bitPack)
        XCTAssert(FixVec(0, 0).bitPack > FixVec(0, -1).bitPack)
    }
    
    func test_1() {
        XCTAssert(FixVec(0, 0).bitPack < FixVec(0, Int64(Int32.max)).bitPack)
        XCTAssert(FixVec(0, 0).bitPack > FixVec(0, Int64(Int32.min)).bitPack)
    }

    func test_2() {
        let a = Int64(Int32.max)
        XCTAssert(FixVec(a, 0).bitPack < FixVec(a, 1).bitPack)
        XCTAssert(FixVec(a, 0).bitPack > FixVec(a, -1).bitPack)
    }
    
    func test_3() {
        let a = Int64(Int32.max)
        XCTAssert(FixVec(a, 0).bitPack < FixVec(a, Int64(Int32.max)).bitPack)
        XCTAssert(FixVec(a, 0).bitPack > FixVec(a, Int64(Int32.min)).bitPack)
    }

    func test_4() {
        let a = Int64(Int32.min)
        XCTAssert(FixVec(a, 0).bitPack < FixVec(a, 1).bitPack)
        XCTAssert(FixVec(a, 0).bitPack > FixVec(a, -1).bitPack)
    }

    func test_5() {
        let a = Int64(Int32.min)
        XCTAssert(FixVec(a, 0).bitPack < FixVec(a, Int64(Int32.max)).bitPack)
        XCTAssert(FixVec(a, 0).bitPack > FixVec(a, Int64(Int32.min)).bitPack)
    }

    
}
