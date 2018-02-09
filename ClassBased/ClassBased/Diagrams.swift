//
//  Diagrams.swift
//  ClassBased
//
//  Created by Chris Eidhof on 01.02.18.
//  Copyright © 2018 objc.io. All rights reserved.
//

import Foundation

open class Diagram {
    public init() {
    }
    open func draw(_ context: CGContext) {
    }
}

public class Rectangle: Diagram {
    let rect: CGRect
    let color: NSColor
    public init(_ rect: CGRect, _ color: NSColor) {
        self.rect = rect
        self.color = color
    }
    override public func draw(_ context: CGContext) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        context.fill(rect)
        context.restoreGState()
    }
}

public class Ellipse: Diagram {
    let rect: CGRect
    let color: NSColor
    public init(in rect: CGRect, _ color: NSColor) {
        self.rect = rect
        self.color = color
    }
    override public func draw(_ context: CGContext) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: rect)
        context.restoreGState()
    }
}

public class Combined: Diagram {
    let d1: Diagram
    let d2: Diagram
    public init(_ d1: Diagram, _ d2: Diagram) {
        self.d1 = d1
        self.d2 = d2
    }
    
    override public func draw(_ context: CGContext) {
        d1.draw(context)
        d2.draw(context)
    }
}
