//
//  IntRect.swift
//
//
//  Created by Nail Sharipov on 18.07.2024.
//

public struct IntRect {
    
    public var minX: Int32
    public var maxX: Int32
    public var minY: Int32
    public var maxY: Int32
    
    
    public var width: Int32 {
        self.maxX - self.minX
    }
    
    public var height: Int32 {
        self.maxY - self.minY
    }
    
    public init(minX: Int32, maxX: Int32, minY: Int32, maxY: Int32) {
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
    }
    
    public init?(points: [Point]) {
        guard let first = points.first else {
            return nil
        }

        var rect = IntRect(minX: first.x, maxX: first.x, minY: first.y, maxY: first.y)

        for p in points {
            rect.unsafeAddPoint(point: p)
        }

        self = rect
    }
    
    public init(rect0: IntRect, rect1: IntRect) {
        self.minX = min(rect0.minX, rect1.minX)
        self.maxX = max(rect0.maxX, rect1.maxX)
        self.minY = min(rect0.minY, rect1.minY)
        self.maxY = max(rect0.maxY, rect1.maxY)
    }

    public init?(rect0: IntRect?, rect1: IntRect?) {
        if rect0 != nil && rect1 != nil {
            self = IntRect(rect0: rect0!, rect1: rect1!)
        } else if rect0 != nil {
            self = rect0!
        } else if rect1 != nil {
            self = rect1!
        } else {
            return nil
        }
    }

    public mutating func addPoint(point: Point) {
        if self.minX > point.x {
            self.minX = point.x
        }

        if self.maxX < point.x {
            self.maxX = point.x
        }

        if self.minY > point.y {
            self.minY = point.y
        }

        if self.maxY < point.y {
            self.maxY = point.y
        }
    }

    public mutating func unsafeAddPoint(point: Point) {
        if self.minX > point.x {
            self.minX = point.x
        } else if self.maxX < point.x {
            self.maxX = point.x
        }

        if self.minY > point.y {
            self.minY = point.y
        } else if self.maxY < point.y {
            self.maxY = point.y
        }
    }

    public func contains(point: Point) -> Bool {
        self.minX <= point.x && point.x <= self.maxX && self.minY <= point.y && point.y <= self.maxY
    }
    
    public func isIntersectBorderInclude(_ other: IntRect) -> Bool {
        let x = self.minX <= other.maxX && self.maxX >= other.minX
        let y = self.minY <= other.maxY && self.maxY >= other.minY
        return x && y
    }
    
    public func isIntersectBorderExclude(_ other: IntRect) -> Bool {
        let x = self.minX < other.maxX && self.maxX > other.minX
        let y = self.minY < other.maxY && self.maxY > other.minY
        return x && y
    }
}
