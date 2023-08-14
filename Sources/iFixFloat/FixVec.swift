//
//  FixVec.swift
//  
//
//  Created by Nail Sharipov on 09.05.2023.
//

import simd

public typealias FixVec = SIMD2<Int64>

public extension FixVec {

    static let zero = FixVec(0, 0)
    
    @inline(__always)
    var isZero: Bool {
        x == 0 && y == 0
    }
    
    @inline(__always)
    var bitPack: Int64 {
        (x << FixFloat.maxBits) + y
    }
     
    @inline(__always)
    init(_ x: FixFloat, _ y: FixFloat) {
        self = .init(x: x, y: y)
    }

    @inline(__always)
    var float: Vec {
        Vec(x.float, y.float)
    }

    @inline(__always)
    var negative: FixVec {
        FixVec(-x, -y)
    }

    @inline(__always)
    var sqrLength: FixFloat {
        let m = self &* self
        return (m.x + m.y).fastNormalize
    }
    
    @inline(__always)
    var length: FixFloat {
        let m = self &* self
        return (m.x + m.y).fastSquareRoot
    }

    @inline(__always)
    var normalize: FixVec {
        let s = (1 << 30) / length
        let xx = (s * x).sqrNormalize
        let yy = (s * y).sqrNormalize
        
        return FixVec(xx, yy)
    }

    @inline(__always)
    func safeNormalize(_ def: FixVec = FixVec(0, .unit)) -> FixVec {
        guard !isZero else {
            return def
        }
        return normalize
    }

    @inline(__always)
    var half: FixVec {
        FixVec(x / 2, y / 2)
    }
    
    @inline(__always)
    static func +(left: FixVec, right: FixVec) -> FixVec {
        left &+ right
    }

    @inline(__always)
    static func -(left: FixVec, right: FixVec) -> FixVec {
        left &- right
    }
    
    @inline(__always)
    static func *(left: FixVec, right: FixFloat) -> FixVec {
        let x = left.x.mul(right)
        let y = left.y.mul(right)
        return FixVec(x, y)
    }
    
    @inline(__always)
    static func *(left: FixFloat, right: FixVec) -> FixVec {
        let x = right.x.mul(left)
        let y = right.y.mul(left)
        return FixVec(x, y)
    }
    
    @inline(__always)
    func unsafeMul(_ v: FixFloat) -> FixVec { // cross product
        FixVec(v * x, v * y)
    }

    @inline(__always)
    func dotProduct(_ v: FixVec) -> FixFloat { // dot product (cos)
        let xx = x.mul(v.x)
        let yy = y.mul(v.y)
        return xx + yy
    }
    
    @inline(__always)
    func unsafeDotProduct(_ v: FixVec) -> FixFloat { // dot product (cos)
        let xx = x * v.x
        let yy = y * v.y
        return xx + yy
    }

    @inline(__always)
    func crossProduct(_ v: FixVec) -> FixFloat { // cross product
        let a = x.mul(v.y)
        let b = y.mul(v.x)

        return a - b
    }
    
    @inline(__always)
    func unsafeCrossProduct(_ v: FixVec) -> FixFloat { // cross product
        let a = x * v.y
        let b = y * v.x

        return a - b
    }
    
    @inline(__always)
    func crossProduct(_ a: FixFloat) -> FixVec { // cross product
        let x0 = a.mul(y)
        let y0 = a.mul(x)

        return FixVec(-x0, y0)
    }

    @inline(__always)
    func sqrDistance(_ v: FixVec) -> FixFloat {
        (self &- v).sqrLength
    }
    
    @inline(__always)
    func distance(_ v: FixVec) -> FixFloat {
        sqrDistance(v).sqrt
    }
    
    @inline(__always)
    func middle(_ v: FixVec) -> FixVec {
        let sum = self + v
        return FixVec(sum.x / 2, sum.y / 2)
    }

}
