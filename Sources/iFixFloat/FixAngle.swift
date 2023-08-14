//
//  FixAngle.swift
//  
//
//  Created by Nail Sharipov on 09.05.2023.
//

public typealias FixAngle = FixFloat

// split 90C to 128
public extension FixAngle {

    static let indexMask: Int64 = 256 - 1
    static let fullRoundMask: Int64 = 1024 - 1
    static let doubleToAngle: Double = 1024 * 512 / Double.pi
    static let doubleToRadian: Double = Double.pi / 512
    static let floatToAngle: Float = 1024 * 512 / Float.pi

    @inline(__always)
    var radian: Double {
        Double(trim) * Int64.doubleToRadian
    }
    
    @inline(__always)
    var trim: FixFloat {
        self & FixAngle.fullRoundMask
    }
    
    @inline(__always)
    var sin: FixFloat {
        let quarter = (self & FixAngle.fullRoundMask) >> 8
        let index = Int(self & FixAngle.indexMask)

        switch quarter {
        case 0:
            return FixAngle.value(index)
        case 1:
            return FixAngle.value(256 - index)
        case 2:
            return -FixAngle.value(index)
        default:
            return -FixAngle.value(256 - index)
        }
    }
    
    @inline(__always)
    var cos: FixFloat {
        let quarter = (self & FixAngle.fullRoundMask) >> 8
        let index = Int(self & FixAngle.indexMask)
        
        switch quarter {
        case 0:
            return FixAngle.value(256 - index)
        case 1:
            return -FixAngle.value(index)
        case 2:
            return -FixAngle.value(256 - index)
        default:
            return FixAngle.value(index)
        }
    }
    
    @inline(__always)
    var rotator: FixVec {
        let quarter = (self & FixAngle.fullRoundMask) >> 8
        let index = Int(self & FixAngle.indexMask)

        let sn: FixFloat
        let cs: FixFloat
        
        switch quarter {
        case 0:
            sn = FixAngle.value(index)
            cs = FixAngle.value(256 - index)
        case 1:
            sn = FixAngle.value(256 - index)
            cs = -FixAngle.value(index)
        case 2:
            sn = -FixAngle.value(index)
            cs = -FixAngle.value(256 - index)
        default:
            sn = -FixAngle.value(256 - index)
            cs = FixAngle.value(index)
        }
        
        return FixVec(x: cs, y: sn)
    }

    @inline(__always)
    static func value(_ index: Int) -> FixFloat {
        let i = index >> 1
        if index & 1 == 1 {
            return (FixSin.map[i] + FixSin.map[i + 1]) >> 1
        } else {
            return FixSin.map[i]
        }
    }

}

public extension Double {
    
    @inline(__always)
    var fixAngle: FixAngle {
        Int64(self * FixAngle.doubleToAngle) >> 10
    }
}

public extension Float {
    
    @inline(__always)
    var fixAngle: FixAngle {
        Int64(self * FixAngle.floatToAngle) >> 10
    }
}

public extension FixFloat {
    
    @inline(__always)
    var angleToFixAngle: FixAngle {
        self / 360
    }
    
    @inline(__always)
    var radToFixAngle: FixAngle {
        (self << 9) / .pi
    }
}
