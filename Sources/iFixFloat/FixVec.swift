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
    
    @inlinable
    var isZero: Bool {
        x == 0 && y == 0
    }
    
    @inlinable
    var bitPack: Int64 {
        (x << FixFloat.maxBits) + y
    }
     
    @inlinable
    init(_ x: FixFloat, _ y: FixFloat) {
        self = .init(x: x, y: y)
    }
    
    @inlinable
    var float: Vec {
        Vec(x.float, y.float)
    }

    @inlinable
    var negative: FixVec {
        FixVec(-x, -y)
    }

    @inlinable
    var sqrLength: FixFloat {
        let m = self &* self
        return (m.x + m.y).fastNormalize
    }
    
    @inlinable
    var length: FixFloat {
        let m = self &* self
        return (m.x + m.y).fastSquareRoot
    }

    @inlinable
    var normalize: FixVec {
        let s = (1 << 30) / length
        let xx = (s * x).sqrNormalize
        let yy = (s * y).sqrNormalize
        
        return FixVec(xx, yy)
    }

    @inlinable
    func safeNormalize(_ def: FixVec = FixVec(0, .unit)) -> FixVec {
        guard !self.isZero else {
            return def
        }
        return self.normalize
    }

    @inlinable
    var half: FixVec {
        FixVec(x / 2, y / 2)
    }
    
    @inlinable
    static func +(left: FixVec, right: FixVec) -> FixVec {
        left &+ right
    }

    @inlinable
    static func -(left: FixVec, right: FixVec) -> FixVec {
        left &- right
    }
    
    @inlinable
    static func *(left: FixVec, right: FixFloat) -> FixVec {
        let x = left.x.mul(right)
        let y = left.y.mul(right)
        return FixVec(x, y)
    }
    
    @inlinable
    static func *(left: FixFloat, right: FixVec) -> FixVec {
        let x = right.x.mul(left)
        let y = right.y.mul(left)
        return FixVec(x, y)
    }
    
    @inlinable
    func unsafeMul(_ v: FixFloat) -> FixVec { // cross product
        FixVec(v * x, v * y)
    }

    @inlinable
    func dotProduct(_ v: FixVec) -> FixFloat { // dot product (cos)
        let xx = x.mul(v.x)
        let yy = y.mul(v.y)
        return xx + yy
    }
    
    @inlinable
    func unsafeDotProduct(_ v: FixVec) -> FixFloat { // dot product (cos)
        let xx = x * v.x
        let yy = y * v.y
        return xx + yy
    }

    @inlinable
    func crossProduct(_ v: FixVec) -> FixFloat { // cross product
        let a = x.mul(v.y)
        let b = y.mul(v.x)

        return a - b
    }
    
    @inlinable
    func unsafeCrossProduct(_ v: FixVec) -> FixFloat { // cross product
        let a = x * v.y
        let b = y * v.x

        return a - b
    }
    
    @inlinable
    func crossProduct(_ a: FixFloat) -> FixVec { // cross product
        let x0 = a.mul(y)
        let y0 = a.mul(x)

        return FixVec(-x0, y0)
    }
    
    @inlinable
    func sqrDistance(_ v: FixVec) -> FixFloat {
        (self &- v).sqrLength
    }
    
    @inlinable
    func distance(_ v: FixVec) -> FixFloat {
        sqrDistance(v).sqrt
    }
    
    @inlinable
    func middle(_ v: FixVec) -> FixVec {
        let sum = self + v
        return FixVec(sum.x / 2, sum.y / 2)
    }
}
