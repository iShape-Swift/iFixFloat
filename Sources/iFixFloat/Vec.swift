//
//  Vec.swift
//  
//
//  Created by Nail Sharipov on 09.05.2023.
//

import simd

public typealias Vec = simd_float2

public extension Vec {
    
    static let zero = Vec(0, 0)
    
    @inline(__always)
    var fix: FixVec {
        FixVec(x.fix, y.fix)
    }
    
    @inline(__always)
    var sqrLength: Float {
        simd_length_squared(self)
    }
    
    @inline(__always)
    var length: Float {
        simd_length(self)
    }

    @inline(__always)
    var normalize: Vec {
        simd_normalize(self)
    }
     
    @inline(__always)
    static func +(left: Vec, right: Vec) -> Vec {
        Vec(left.x + right.x, left.y + right.y)
    }

    @inline(__always)
    static func -(left: Vec, right: Vec) -> Vec {
        Vec(left.x - right.x, left.y - right.y)
    }

    @inline(__always)
    func dotProduct(_ v: Vec) -> Float { // dot product (cos)
        simd_dot(self, v)
    }

    @inline(__always)
    func crossProduct(_ v: Vec) -> Float { // cross product
        x * v.y - y * v.x
    }

}
