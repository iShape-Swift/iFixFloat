//
//  BitPack.swift
//
//
//  Created by Nail Sharipov on 12.01.2024.
//

public typealias BitPack = UInt64

public extension FixVec {
    
    static let maxBits = UInt32.bitWidth - 1
    static let fixMid = Int64(1) << maxBits
    static let yBitMask = UInt64(UInt32.max)
    
    @inlinable
    var bitPack: UInt64 {
        var xx = UInt64(self.x + FixVec.fixMid)
        let yy = UInt64(self.y + FixVec.fixMid)
        xx = xx << UInt32.bitWidth

        return xx | yy
    }
}

public extension BitPack {
 
    static let halfBits = Int64.bitWidth >> 1
    
    @inlinable
    var fixVec: FixVec {
        let x = Int64(self >> UInt32.bitWidth) - FixVec.fixMid
        let y = Int64(self & FixVec.yBitMask) - FixVec.fixMid
        
        return FixVec(x, y)
    }
    
}
