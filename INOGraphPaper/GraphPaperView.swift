//
//  GraphPaperView.swift
//  WordWright
//
//  Created by Aaron Vegh on 2015-11-12.
//  Copyright © 2015 Aaron Vegh. All rights reserved.
//

import UIKit

enum AxisDirection:String {
    case Horizontal = "Horizontal"
    case Vertical = "Vertical"
}

@IBDesignable class GraphPaperView: UIView {

    @IBInspectable var majorLineDistance:Int = 50
    @IBInspectable var minorLineDistance:Int = 10
    @IBInspectable var majorLineColour:UIColor = UIColor.blueColor()
    @IBInspectable var minorLineColour:UIColor = UIColor.lightGrayColor()
    
    override func drawRect(rect: CGRect) {
        
        // Iterate through the X and Y axes, for first the minor, then major lines
        // Core Graphics "paints" lines as they're drawn, so the majors will end up 
        // on top of the minors.
        
        for (var x = 0; x <= Int(self.bounds.size.width); x++) {
            if x % minorLineDistance == 0 {
                self.drawGraphLine(x, axis:.Vertical, colour: self.minorLineColour, major:false)
            }
        }
        
        for (var y = 0; y <= Int(self.bounds.size.height); y++) {
            if y % minorLineDistance == 0 {
                self.drawGraphLine(y, axis:.Horizontal, colour: self.minorLineColour, major:false)
            }
        }
        
        for (var x = 0; x <= Int(self.bounds.size.width); x++) {
            if x % majorLineDistance == 0 {
                self.drawGraphLine(x, axis:.Vertical, colour: self.majorLineColour, major:true)
            }
        }
        
        for (var y = 0; y <= Int(self.bounds.size.height); y++) {
            if y % majorLineDistance == 0 {
                self.drawGraphLine(y, axis:.Horizontal, colour: self.majorLineColour, major:true)
            }
        }
        
    }
    
    func drawGraphLine(position:Int, axis:AxisDirection, colour:UIColor, major:Bool) {
        let context = UIGraphicsGetCurrentContext()
        
        switch axis {
            case .Vertical:
                CGContextMoveToPoint(context, CGFloat(position), 0)
                CGContextAddLineToPoint(context, CGFloat(position), self.bounds.size.height)
            case .Horizontal:
                CGContextMoveToPoint(context, 0, CGFloat(position))
                CGContextAddLineToPoint(context, self.bounds.size.width, CGFloat(position))
        }
        
        if major {
            CGContextSetLineWidth(context, 2)
        }
        else {
            CGContextSetLineWidth(context, 1)
        }
        
        colour.setStroke()
        
        CGContextStrokePath(context)
    }

}
