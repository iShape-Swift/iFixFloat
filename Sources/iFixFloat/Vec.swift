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
    
    @inlinable
    var fix: FixVec {
        FixVec(x.fix, y.fix)
    }
    
    @inlinable
    var sqrLength: Float {
        simd_length_squared(self)
    }
    
    @inlinable
    var length: Float {
        simd_length(self)
    }

    @inlinable
    var normalize: Vec {
        simd_normalize(self)
    }
     
    @inlinable
    static func +(left: Vec, right: Vec) -> Vec {
        Vec(left.x + right.x, left.y + right.y)
    }

    @inlinable
    static func -(left: Vec, right: Vec) -> Vec {
        Vec(left.x - right.x, left.y - right.y)
    }

    @inlinable
    func dotProduct(_ v: Vec) -> Float { // dot product (cos)
        simd_dot(self, v)
    }

    @inlinable
    func crossProduct(_ v: Vec) -> Float { // cross product
        x * v.y - y * v.x
    }

}
