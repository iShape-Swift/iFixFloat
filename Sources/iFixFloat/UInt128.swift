//
//  UInt128.swift
//  
//
//  Created by Nail Sharipov on 23.10.2023.
//

public struct UInt128 {
    
    public var high: UInt64
    public var low: UInt64
    
    @inline(__always)
    init(high: UInt64, low: UInt64) {
        self.high = high
        self.low = low
    }
    
    @inline(__always)
    static func sum(_ a: UInt64, _ b: UInt64, _ c: UInt64) -> (partialValue: UInt64, high: UInt64) {
        let s0 = a.addingReportingOverflow(b)
        var high: UInt64 = s0.overflow ? 1 : 0
        let s1 = s0.partialValue.addingReportingOverflow(c)
        high += s1.overflow ? 1 : 0
        
        return (s1.partialValue, high)
    }

    @inline(__always)
    public static func multiply(_ a: UInt64, _ b: UInt64) -> UInt128 {
        guard a.leadingZeroBitCount + b.leadingZeroBitCount < UInt64.bitWidth else {
            return UInt128(high: 0, low: a * b)
        }
        let a1 = a >> 32
        let a0 = a & 0xFFFF_FFFF
        let b1 = b >> 32
        let b0 = b & 0xFFFF_FFFF
        
        let ab00 = a0 * b0
        
        let m = sum(a0 * b1, a1 * b0, ab00 >> 32)
        let high = a1 * b1 + (m.partialValue >> 32) + (m.high << 32)
        
        let low = (m.partialValue << 32) | (ab00 & 0xFFFF_FFFF)
        
        
        return UInt128(high: high, low: low)
    }
    
    @inline(__always)
    public static func == (lhs: UInt128, rhs: UInt128) -> Bool {
        return lhs.high == rhs.high && lhs.low == rhs.low
    }
    
    @inline(__always)
    public static func < (lhs: UInt128, rhs: UInt128) -> Bool {
        if lhs.high != rhs.high {
            return lhs.high < rhs.high
        }
        return lhs.low < rhs.low
    }
    
    @inline(__always)
    public static func <= (lhs: UInt128, rhs: UInt128) -> Bool {
        if lhs.high != rhs.high {
            return lhs.high < rhs.high
        }
        return lhs.low <= rhs.low
    }
    
    @inline(__always)
    public static func > (lhs: UInt128, rhs: UInt128) -> Bool {
        if lhs.high != rhs.high {
            return lhs.high > rhs.high
        }
        return lhs.low > rhs.low
    }
    
    @inline(__always)
    public static func >= (lhs: UInt128, rhs: UInt128) -> Bool {
        if lhs.high != rhs.high {
            return lhs.high > rhs.high
        }
        return lhs.low >= rhs.low
    }
}
