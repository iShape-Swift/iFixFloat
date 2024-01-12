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
        XCTAssert(FixVec(0, 0).bitPack < FixVec(0, .fixMax).bitPack)
        XCTAssert(FixVec(0, 0).bitPack > FixVec(0, .fixMin).bitPack)
    }

    func test_2() {
        XCTAssert(FixVec(.fixMax, 0).bitPack < FixVec(.fixMax, 1).bitPack)
        XCTAssert(FixVec(.fixMax, 0).bitPack > FixVec(.fixMax, -1).bitPack)
    }
    
    func test_3() {
        XCTAssert(FixVec(.fixMax, 0).bitPack < FixVec(.fixMax, .fixMax).bitPack)
        XCTAssert(FixVec(.fixMax, 0).bitPack > FixVec(.fixMax, .fixMin).bitPack)
    }

    func test_4() {
        XCTAssert(FixVec(.fixMin, 0).bitPack < FixVec(.fixMin, 1).bitPack)
        
        let b0 = FixVec(.fixMin,  0).bitPack
        let b1 = FixVec(.fixMin, -1).bitPack
        
        XCTAssert(b0 > b1)
    }

    func test_5() {
        XCTAssert(FixVec(.fixMin, 0).bitPack < FixVec(.fixMin, .fixMax).bitPack)
        XCTAssert(FixVec(.fixMin, 0).bitPack > FixVec(.fixMin, .fixMin).bitPack)
    }
    
    func test_6() {
        XCTAssertEqual(FixVec(.fixMax, .fixMax).bitPack, UInt64.max)
        XCTAssertEqual(FixVec(.fixMin, .fixMin).bitPack, 0)
    }
    
    func test_7() {
        let p = FixVec(-10, 10)
        let b = p.bitPack
        let v = b.fixVec
        
        XCTAssertEqual(p, v)
    }
    
    func test_8() {
        let p = FixVec(10, -10)
        let b = p.bitPack
        let v = b.fixVec
        
        XCTAssertEqual(p, v)
    }

    func test_9() {
        XCTAssertEqual(FixVec(.fixMin + 1, .fixMin + 1).bitPack.fixVec, FixVec(.fixMin + 1, .fixMin + 1))
        XCTAssertEqual(FixVec(.fixMax - 1, .fixMax - 1).bitPack.fixVec, FixVec(.fixMax - 1, .fixMax - 1))
    }
    
    func test_10() {
        for i in 1..<Int32.bitWidth {
            let v = Int64(1 << i) - 1
            let a = FixVec(v, -v)
            let b = FixVec(-v, v)
            XCTAssertEqual(a.bitPack.fixVec, a)
            XCTAssertEqual(b.bitPack.fixVec, b)
        }
    }
    
    func test_11() {
        var b = FixVec(.fixMin, .fixMin)
        for x in Int8.min...Int8.max {
            for y in Int8.min...Int8.max {
                let a = FixVec(Int64(x), Int64(y))
                XCTAssert(b.bitPack < a.bitPack)
                XCTAssertEqual(a.bitPack.fixVec, a)
                b = a
            }
        }
    }
    
    
    func test_random() {
        let min = Int32.min
        let max = Int32.max
        
        for _ in 0..<100_000 {
            let x = Int64(Int32.random(in: min...max))
            let y = Int64(Int32.random(in: min...max))
            let p = FixVec(x, y)
            let v = p.bitPack.fixVec
            XCTAssertEqual(p, v)
        }
    }
    
}
