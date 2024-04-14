//
//  LineChartView.swift
//  Calculus Helper
//
//  Created by S. Adams on 4/9/24.
//

import Foundation
import UIKit

class LineChartView: UIView {
    var dataPoints: [CGPoint] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Set up drawing properties
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.cyan.cgColor)
        
        // Draw x-axis
        context.move(to: CGPoint(x: 0, y: rect.height / 2))
        context.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        context.strokePath()
        
        // Draw y-axis
        context.move(to: CGPoint(x: rect.width / 2, y: 0))
        context.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
        context.strokePath()
        
        // Draw data points
        guard !dataPoints.isEmpty else { return }
        
        context.setStrokeColor(UIColor.magenta.cgColor)
        context.beginPath()
        
        for point in dataPoints {
            context.addArc(center: point, radius: 3.0, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        }
        
        context.strokePath()
    }
}
