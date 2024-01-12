//
//  BitPack.swift
//
//
//  Created by Nail Sharipov on 12.01.2024.
//

public typealias BitPack = UInt64

public extension FixVec {
    
    static let fixMid = Int64(1) << (UInt32.bitWidth - 1)
    static let yMask = UInt64(UInt32.max)
    
    @inlinable
    var bitPack: UInt64 {
        let xx = UInt64(self.x + FixVec.fixMid) << UInt32.bitWidth
        let yy = UInt64(self.y + FixVec.fixMid)

        return xx | yy
    }
}

public extension BitPack {
    
    @inlinable
    var fixVec: FixVec {
        let x = Int64(self >> UInt32.bitWidth) - FixVec.fixMid
        let y = Int64(self & FixVec.yMask) - FixVec.fixMid
        
        return FixVec(x, y)
    }
    
}
