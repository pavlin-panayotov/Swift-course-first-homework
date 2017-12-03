//
//  Extensions.swift
//  PercentsView
//
//  Created by Pavlin Panayotov on 3.12.17.
//  Copyright © 2017 Pavlin Panayotov. All rights reserved.
//

import UIKit

private let lineWidth: CGFloat = 35
private let percentsSum = 100
private let minimumPercent = 7

extension CGSize {
    
    var isSquare: Bool {
        return width == height
    }
}

extension Array where Element == Int {
    
    var elementsSum: Element {
        return reduce(0) { sum, current in
            return sum + current
        }
    }
}

extension Int {
    
    var toString: String {
        return String(self)
    }
}

// final
extension UIView {
    
    private func isDataValid(percents: [Int], colors: [UIColor]) -> Bool {
        guard bounds.size.isSquare else {
            assert(false, "View is not square.")
            return false
        }
        
        guard percents.count <= colors.count else {
            assert(false, "Not enough colors.")
            return false
        }
        
        guard percents.elementsSum == percentsSum else {
            assert(false, "Percents sum should be 100.")
            return false
        }
        
        for percent in percents {
            guard percent < minimumPercent else {
                continue
            }
            
            assert(false, "Undefined case.")
            return false
        }
        
        return true
    }
    
    func addLayers(percents: [Int], colors: [UIColor]) {
        guard isDataValid(percents: percents, colors: colors) else {
            return
        }
        
        let arcCenter = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        let radius = (bounds.size.width - lineWidth)/2
        
        var nextStartingAngle: CGFloat = 0
        var labelsCenter = [CGPoint]()
        
        for (percent, color) in zip(percents, colors) {
            let endAngle = nextStartingAngle + CGFloat.pi * 2 * CGFloat(percent) / CGFloat(percentsSum)
            
            let circlePath = UIBezierPath(
                arcCenter: arcCenter,
                radius: radius,
                startAngle: nextStartingAngle,
                endAngle: endAngle,
                clockwise: true
            )
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.strokeColor = color.cgColor
            shapeLayer.lineWidth = lineWidth
            
            layer.addSublayer(shapeLayer)
            
            nextStartingAngle = endAngle
            
            labelsCenter.append(
                CGPoint(
                    x: arcCenter.x + radius * cos(nextStartingAngle),
                    y: arcCenter.y + radius * sin(nextStartingAngle)
                )
            )
        }
        
        addLabels(centers: labelsCenter, percents: percents, colors: colors)
    }
    
    private func addLabels(centers: [CGPoint], percents: [Int], colors: [UIColor]) {
        for (index, center) in centers.enumerated() {
            let color = colors[index]
            let percent = percents[index]
            
            // draw circle
            let circlePath = UIBezierPath(
                arcCenter: center,
                radius: (lineWidth - 1)/2,
                startAngle: 0,
                endAngle: CGFloat.pi * 2,
                clockwise: true
            )
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = color.cgColor
            shapeLayer.strokeColor = shapeLayer.fillColor
            shapeLayer.lineWidth = 1
            
            layer.addSublayer(shapeLayer)
            
            // draw label
            let textLayer = CATextLayer()
            textLayer.bounds = CGRect(x: 0, y: 0, width: lineWidth/2, height: lineWidth/2)
            textLayer.fontSize = 12
            textLayer.font = UIFont.boldSystemFont(ofSize: 12)
            textLayer.alignmentMode = "center"
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.string = percent.toString
            textLayer.position = center
            layer.addSublayer(textLayer)
        }
    }
}
