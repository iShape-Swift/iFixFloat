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
    init(_ x: FixFloat, _ y: FixFloat) {
        self = .init(x: x, y: y)
    }
    
    @inline(__always)
    init(_ p: Point) {
        self = .init(x: Int64(p.x), y: Int64(p.y))
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
    var fixSqrLength: FixFloat {
        let m = self &* self
        return (m.x + m.y).fixFastNormalize
    }

    @inline(__always)
    var fixLength: FixFloat {
        let m = self &* self
        return (m.x + m.y).sqrt
    }

    @inline(__always)
    var fixNormalize: FixVec {
        let s = (1 << 30) / fixLength
        let xx = (s * x).fixSqrNormalize
        let yy = (s * y).fixSqrNormalize
        
        return FixVec(xx, yy)
    }

    @inline(__always)
    func fixSafeNormalize(_ def: FixVec = FixVec(0, .unit)) -> FixVec {
        guard !isZero else {
            return def
        }
        return fixNormalize
    }
    
    @inline(__always)
    func fixMul(_ right: FixFloat) -> FixVec {
        let x = self.x.fixMul(right)
        let y = self.y.fixMul(right)
        return FixVec(x, y)
    }
    
    @inline(__always)
    func fixDotProduct(_ v: FixVec) -> FixFloat { // dot product (cos)
        let xx = x.fixMul(v.x)
        let yy = y.fixMul(v.y)
        return xx + yy
    }
    
    
    @inline(__always)
    func fixCrossProduct(_ a: FixFloat) -> FixVec { // cross product
        let x0 = a.fixMul(y)
        let y0 = a.fixMul(x)

        return FixVec(-x0, y0)
    }
    
    @inline(__always)
    func fixCrossProduct(_ v: FixVec) -> FixFloat { // cross product
        let a = x.fixMul(v.y)
        let b = y.fixMul(v.x)

        return a - b
    }

    @inline(__always)
    func fixSqrDistance(_ v: FixVec) -> FixFloat {
        (self &- v).fixSqrLength
    }
    
    @inline(__always)
    func distance(_ v: FixVec) -> FixFloat {
        fixSqrDistance(v).fixSqrt
    }
    
    @inline(__always)
    func sqrDistance(_ v: FixVec) -> FixFloat {
        (self &- v).sqrLength
    }
    
    
    @inline(__always)
    var half: FixVec {
        FixVec(x / 2, y / 2)
    }

    @inline(__always)
    func middle(_ v: FixVec) -> FixVec {
        let sum = self + v
        return FixVec(sum.x / 2, sum.y / 2)
    }
    
    @inline(__always)
    var sqrLength: FixFloat {
        let m = self &* self
        return m.x + m.y
    }
    
    @inline(__always)
    var length: FixFloat {
        let m = self &* self
        return m.x + m.y
    }
    
    @inline(__always)
    func dotProduct(_ v: FixVec) -> FixFloat { // dot product (cos)
        let xx = x * v.x
        let yy = y * v.y
        return xx + yy
    }
    
    @inline(__always)
    func crossProduct(_ v: FixVec) -> FixFloat { // cross product
        let a = x * v.y
        let b = y * v.x

        return a - b
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
        let x = left.x * right
        let y = left.y * right
        return FixVec(x, y)
    }
    
    @inline(__always)
    static func *(left: FixFloat, right: FixVec) -> FixVec {
        let x = right.x * left
        let y = right.y * left
        return FixVec(x, y)
    }
    
    @inline(__always)
    func unsafeMul(_ v: FixFloat) -> FixVec { // cross product
        FixVec(v * x, v * y)
    }
}
