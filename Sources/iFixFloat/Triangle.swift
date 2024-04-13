//
//  Triangle.swift
//  
//
//  Created by Nail Sharipov on 10.07.2023.
//

public struct Triangle {

    @inline(__always)
    public static func unsafeAreaTwo(p0: FixVec, p1: FixVec, p2: FixVec) -> FixFloat {
        (p1 - p0).crossProduct(p1 - p2)
    }
    
    @inline(__always)
    public static func unsafeArea(p0: FixVec, p1: FixVec, p2: FixVec) -> FixFloat {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2) / 2
    }
    
    @inline(__always)
    public static func fixArea(p0: FixVec, p1: FixVec, p2: FixVec) -> FixFloat {
        (p1 - p0).fixCrossProduct(p1 - p2) / 2
    }
    
    @inline(__always)
    public static func fixAreaTwo(p0: FixVec, p1: FixVec, p2: FixVec) -> FixFloat {
        (p1 - p0).fixCrossProduct(p1 - p2)
    }
    
    @inline(__always)
    public static func isClockwise(p0: FixVec, p1: FixVec, p2: FixVec) -> Bool {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2) > 0
    }

    @inline(__always)
    public static func isCW_or_Line(p0: FixVec, p1: FixVec, p2: FixVec) -> Bool {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2) >= 0
    }
    
    @inline(__always)
    public static func isNotLine(p0: FixVec, p1: FixVec, p2: FixVec) -> Bool {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2) != 0
    }
    
    @inline(__always)
    public static func isLine(p0: FixVec, p1: FixVec, p2: FixVec) -> Bool {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2) == 0
    }
    
    @inline(__always)
    public static func clockDirection(p0: FixVec, p1: FixVec, p2: FixVec) -> Int64 {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2).signum()
    }
    
    @inline(__always)
    public static func isContain(p: Point, p0: Point, p1: Point, p2: Point) -> Bool {
        let q0 = p.subtract(p1).crossProduct(p0.subtract(p1))
        let q1 = p.subtract(p2).crossProduct(p1.subtract(p2))
        let q2 = p.subtract(p0).crossProduct(p2.subtract(p0))
        
        let has_neg = q0 < 0 || q1 < 0 || q2 < 0
        let has_pos = q0 > 0 || q1 > 0 || q2 > 0
        
        return !(has_neg && has_pos)
    }
    
    @inline(__always)
    public static func isNotContain(p: FixVec, p0: FixVec, p1: FixVec, p2: FixVec) -> Bool {
        let q0 = (p - p1).crossProduct(p0 - p1)
        let q1 = (p - p2).crossProduct(p1 - p2)
        let q2 = (p - p0).crossProduct(p2 - p0)
        
        let has_neg = q0 <= 0 || q1 <= 0 || q2 <= 0
        let has_pos = q0 >= 0 || q1 >= 0 || q2 >= 0
        
        return has_neg && has_pos
    }

    @inline(__always)
    public static func unsafeAreaTwo(p0: Point, p1: Point, p2: Point) -> Int64 {
        p1.subtract(p0).crossProduct(p1.subtract(p2))
    }
    
    @inline(__always)
    public static func isClockwise(p0: Point, p1: Point, p2: Point) -> Bool {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2) > 0
    }
    
    @inline(__always)
    public static func isCW_or_Line(p0: Point, p1: Point, p2: Point) -> Bool {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2) >= 0
    }
    
    @inline(__always)
    public static func isNotLine(p0: Point, p1: Point, p2: Point) -> Bool {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2) != 0
    }
    
    @inline(__always)
    public static func isLine(p0: Point, p1: Point, p2: Point) -> Bool {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2) == 0
    }
    
    @inline(__always)
    public static func clockDirection(p0: Point, p1: Point, p2: Point) -> Int64 {
        unsafeAreaTwo(p0: p0, p1: p1, p2: p2).signum()
    }
}
