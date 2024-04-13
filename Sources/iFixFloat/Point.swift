//
//  Point.swift
//
//
//  Created by Nail Sharipov on 25.01.2024.
//

import simd

public typealias Point = SIMD2<Int32>

public extension Point {
    
    @inline(__always)
    var sqrLength: Int64 {
        let x = Int64(x)
        let y = Int64(y)
        return x * x + y * y
    }

    @inline(__always)
    init(_ p: FixVec) {
        self = .init(x: Int32(p.x), y: Int32(p.y))
    }
    
    @inline(__always)
    func crossProduct(_ v: Point) -> Int64 { // cross product (sin)
        let a = Int64(x) * Int64(v.y)
        let b = Int64(y) * Int64(v.x)

        return a - b
    }
    
    @inline(__always)
    func dotProduct(_ v: Point) -> Int64 { // dot product (cos)
        let xx = Int64(x) * Int64(v.x)
        let yy = Int64(y) * Int64(v.y)
        return xx + yy
    }
    
    
    @inline(__always)
    func subtract(_ other: Point) -> FixVec {
        let x = Int64(self.x) - Int64(other.x)
        let y = Int64(self.y) - Int64(other.y)
        return FixVec(x, y)
    }
    
    
    @inline(__always)
    func sqrDistance(_ v: Point) -> Int64 {
        let x = Int64(x) - Int64(v.x)
        let y = Int64(y) - Int64(v.y)
        return x * x + y * y
    }
}
