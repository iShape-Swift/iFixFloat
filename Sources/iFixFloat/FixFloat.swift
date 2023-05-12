public typealias FixFloat = Int64
public typealias FixDouble = Int64

public extension FixFloat {
    
    static let fractionBits: Int64 = 10
    static let sqrFactionBits: Int64 = 20
    static let maxBits = (Int64.bitWidth >> 1) - 1
    static let max: Int64 = (Int64(1) << maxBits) - 1
    static let min: Int64 = -max
    
    static let unit: Int64 = 1 << fractionBits
    static let sqrUnit: Int64 = 1 << sqrFactionBits
    static let half: Int64 = 1 << (fractionBits - 1)
    
    
    static let pi: FixFloat = 3217
    
    @inlinable
    func div(_ value: FixFloat) -> FixFloat {
        (self << FixFloat.fractionBits) / value
    }
    
    @inlinable
    func div(fixDouble value: FixFloat) -> FixFloat {
        (self << FixFloat.sqrFactionBits) / value
    }
    
    @inlinable
    func mul(_ value: FixFloat) -> FixFloat {
        (self * value).normalize
    }
    
    @inlinable
    func mul(fixDouble value: FixFloat) -> FixFloat {
        (self * value).sqrNormalize
    }

    @inlinable
    var sqr: FixFloat {
        (self * self).fastNormalize
    }
    
    @inlinable
    var sqrt: FixFloat {
        (self << FixFloat.fractionBits).fastSquareRoot
    }

    @inlinable
    var double: Double {
        Double(self) / Double(FixFloat.unit)
    }
    
    @inlinable
    var float: Float {
        Float(self) / Float(FixFloat.unit)
    }

    @inlinable
    var int: Int {
        Int(self >> FixFloat.fractionBits)
    }
    
    @inlinable
    var normalize: FixFloat {
        self / .unit
    }
    
    @inlinable
    var sqrNormalize: FixFloat {
        self / .sqrUnit
    }

    @inlinable
    var fastNormalize: FixFloat {
        self >> FixFloat.fractionBits
    }

    @inlinable
    func clamp(min: FixFloat, max: FixFloat) -> FixFloat {
        Swift.min(max, Swift.max(min, self))
    }
}

public extension Double {
    
    @inlinable
    var fix: FixFloat {
        Int64(self * Double(FixFloat.unit))
    }
}

public extension Float {
    
    @inlinable
    var fix: FixFloat {
        Int64(self * Float(FixFloat.unit))
    }
}

public extension Int {
    
    @inlinable
    var fix: FixFloat {
        Int64(self << FixFloat.fractionBits)
    }
}

extension Int64 {

    @inlinable
    var fastSquareRoot: Int64 {
        let a = Int64(Double(self).squareRoot())
        let b = a + 1

        return b * b > self ? a : b
    }
}
