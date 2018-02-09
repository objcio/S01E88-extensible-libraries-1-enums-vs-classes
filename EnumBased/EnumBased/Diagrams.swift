//
//  Diagrams.swift
//  EnumBased
//
//  Created by Chris Eidhof on 01.02.18.
//  Copyright © 2018 objc.io. All rights reserved.
//

import Foundation

public enum Diagram {
    case rectangle(CGRect, NSColor)
    case ellipse(in: CGRect, NSColor)
    indirect case combined(Diagram, Diagram)
    indirect case alpha(CGFloat, Diagram)
}

extension Diagram {
    public func draw(_ context: CGContext) {
        context.saveGState()
        switch self {
        case let .rectangle(rect, color):
            context.setFillColor(color.cgColor)
            context.fill(rect)
        case let .ellipse(rect, color):
            context.setFillColor(color.cgColor)
            context.fillEllipse(in: rect)
        case let .combined(d1, d2):
            d1.draw(context)
            d2.draw(context)
        case let .alpha(alpha, d):
            context.setAlpha(alpha)
            d.draw(context)
        }
        context.restoreGState()
    }
}
