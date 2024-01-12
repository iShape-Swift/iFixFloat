public typealias FixFloat = Int64
public typealias FixDouble = Int64

public extension FixFloat {
    
    static let fractionBits: Int64 = 10
    static let sqrFactionBits: Int64 = 20
    static let cubeFactionBits: Int64 = 30
    static let tetraFactionBits: Int64 = 40
    static let pentaFactionBits: Int64 = 50
    static let fixMax: Int64 = Int64(Int32.max)
    static let fixMin: Int64 = Int64(Int32.min)
    
    static let unit: Int64 = 1 << fractionBits
    static let sqrUnit: Int64 = 1 << sqrFactionBits
    static let cubeUnit: Int64 = 1 << cubeFactionBits
    static let half: Int64 = 1 << (fractionBits - 1)
    static let pi: FixFloat = 3217
    
    @inline(__always)
    func fixDiv(_ value: FixFloat) -> FixFloat {
        (self << FixFloat.fractionBits) / value
    }
    
    @inline(__always)
    func fivDiv(doubleValue value: FixFloat) -> FixFloat {
        (self << FixFloat.sqrFactionBits) / value
    }
    
    @inline(__always)
    func fixMul(_ value: FixFloat) -> FixFloat {
        (self * value).fixNormalize
    }
    
    @inline(__always)
    func fixMul(doubleValue value: FixFloat) -> FixFloat {
        (self * value).fixSqrNormalize
    }

    @inline(__always)
    var fixSqr: FixFloat {
        (self * self).fixFastNormalize
    }
    
    @inline(__always)
    var fixSqrt: FixFloat {
        (self << FixFloat.fractionBits).sqrt
    }

    @inline(__always)
    var double: Double {
        Double(self) / Double(FixFloat.unit)
    }
    
    @inline(__always)
    var float: Float {
        Float(self) / Float(FixFloat.unit)
    }

    @inline(__always)
    var int: Int {
        Int(self >> FixFloat.fractionBits)
    }
    
    @inline(__always)
    var fixNormalize: FixFloat {
        self / .unit
    }
    
    @inline(__always)
    var fixSqrNormalize: FixFloat {
        self / .sqrUnit
    }

    @inline(__always)
    var fixFastNormalize: FixFloat {
        self >> FixFloat.fractionBits
    }

    @inline(__always)
    func clamp(min: FixFloat, max: FixFloat) -> FixFloat {
        Swift.min(max, Swift.max(min, self))
    }
    
    @inline(__always)
    var invert: FixFloat {
        (1 << FixFloat.sqrFactionBits) / self
    }

    @inline(__always)
    var doubleInvert: FixDouble {
        (1 << FixFloat.cubeFactionBits) / self
    }
    
}

public extension Double {
    
    @inline(__always)
    var fix: FixFloat {
        Int64(self * Double(FixFloat.unit))
    }
}

public extension Float {
    
    @inline(__always)
    var fix: FixFloat {
        Int64(self * Float(FixFloat.unit))
    }
}

public extension Int {
    
    @inline(__always)
    var fix: FixFloat {
        Int64(self << FixFloat.fractionBits)
    }
}

extension Int64 {

    @inline(__always)
    var sqrt: Int64 {
        let a = Int64(Double(self).squareRoot())
        let b = a + 1

        return b * b > self ? a : b
    }
}
