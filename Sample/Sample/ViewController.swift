//
//  ViewController.swift
//  Sample
//
//  Created by Chris Eidhof on 01.02.18.
//  Copyright © 2018 objc.io. All rights reserved.
//

import Cocoa

final class LayerView: NSView {
    convenience init(_ rect: CGRect, _ layer: CALayer) {
        self.init(frame: rect)
        self.layer = layer
        self.layerUsesCoreImageFilters = true
    }
    
    override var isFlipped: Bool { return true }
}

final class CGContextView: NSView {
    let render: (CGContext) -> ()
    init(frame: CGRect, render: @escaping (CGContext) -> ()) {
        self.render = render
        super.init(frame: frame)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ dirtyRect: NSRect) {
        render(NSGraphicsContext.current!.cgContext)
    }
    
    override var isFlipped: Bool { return true }
}







import ClassBased

let diagram = Combined(
    Rectangle(CGRect(x: 20, y: 20, width: 100, height: 100), .red),
    Alpha(alpha: 0.5, diagram: Ellipse(in: CGRect(x: 60, y: 60, width: 80, height: 100), .green))
)

//let diagram = Diagram.combined(
//    .rectangle(CGRect(x: 20, y: 20, width: 100, height: 100), .red),
//    .alpha(0.5, .ellipse(in: CGRect(x: 60, y: 60, width: 80, height: 100), .green))
//)

//extension Diagram {
//    func render() -> CALayer {
//        switch self {
//        case let .rectangle(rect, color):
//            let result = CALayer()
//            result.frame = rect
//            result.backgroundColor = color.cgColor
//            return result
//        case let .ellipse(rect, color):
//            let result = CAShapeLayer()
//            result.path = CGPath(ellipseIn: rect, transform: nil)
//            result.fillColor = color.cgColor
//            return result
//        case let .combined(d1, d2):
//            let result = CALayer()
//            result.addSublayer(d1.render())
//            result.addSublayer(d2.render())
//            return result
//        case let .alpha(alpha, d):
//            let result = CALayer()
//            result.opacity = Float(alpha)
//            result.addSublayer(d.render())
//            return result
//        }
//    }
//}
//

class Alpha: Diagram {
    let alpha: CGFloat
    let diagram: Diagram
    init(alpha: CGFloat, diagram: Diagram) {
        self.alpha = alpha
        self.diagram = diagram
    }
    override func draw(_ context: CGContext) {
        context.saveGState()
        context.setAlpha(alpha)
        diagram.draw(context)
        context.restoreGState()
    }
}

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let diagramView = CGContextView(frame: frame, render: diagram.draw)
////        let diagramView = LayerView(frame, diagram.render())
        view.addSubview(diagramView)
    }
}





