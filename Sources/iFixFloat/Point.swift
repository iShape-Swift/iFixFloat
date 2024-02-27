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
    init(_ p: FixVec) {
        self = .init(x: Int32(p.x), y: Int32(p.y))
    }
}
