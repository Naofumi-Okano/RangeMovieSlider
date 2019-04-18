//
//  RangeMovieSliderKnob.swift
//  RangeMovieSlider
//
//  Created by 岡野 直史 on 2019/04/18.
//  Copyright © 2019年 岡野 直史. All rights reserved.
//

import UIKit
import QuartzCore

enum Knob {
    case Neither
    case Lower
    case Upper
    case Both
}

public enum KnobAnchorPosition {
    case inside
    case center
}

class RangeMovieSliderKnob: CALayer {
    static var KnobDelta: CGFloat = 2.0
    static var KnobLeftPadding: CGFloat = 2.0
    static var KnobRightPadding: CGFloat = 24.0
    static var KnobRadii: CGFloat = 10.0
    
    var highlighted: Bool = false {
        didSet {
            if let superLayer = superlayer, highlighted {
                removeFromSuperlayer()
                superLayer.addSublayer(self)
            }
            setNeedsDisplay()
        }
    }
    
    var isLower: Bool = false
    weak var rangeSlider: RangeMovieSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            // Params
            let lPadding = isLower ? RangeMovieSliderKnob.KnobLeftPadding : RangeMovieSliderKnob.KnobRightPadding
            let rPadding = isLower ? RangeMovieSliderKnob.KnobRightPadding : RangeMovieSliderKnob.KnobLeftPadding
            let corners:UIRectCorner = isLower ? [.bottomLeft, .topLeft] : [.bottomRight, .topRight]
            let imageName = isLower ? "icon_capture_edit_arrow" : "icon_capture_edit_arrow_return"
            let imagePadding = isLower ? RangeMovieSliderKnob.KnobLeftPadding : RangeMovieSliderKnob.KnobRightPadding
            
            // Process
            let knobFrame = bounds.inset(by: UIEdgeInsets.init(top: 0, left: lPadding, bottom: 0, right: rPadding))
            let knobPath = UIBezierPath(roundedRect: knobFrame, byRoundingCorners: corners, cornerRadii: CGSize(width: RangeMovieSliderKnob.KnobRadii, height: RangeMovieSliderKnob.KnobRadii))
            ctx.setFillColor(slider.knobTintColor.cgColor)
            ctx.addPath(knobPath.cgPath)
            ctx.fillPath()
            guard let image = UIImage(named: imageName) else { return }
            let x = (knobFrame.width / 2) - (image.size.width / 2) + imagePadding
            let y = (knobFrame.height/2 - image.size.height/2)
            let drawRect:CGRect = CGRect.init(x: x, y: y, width: image.size.width, height: image.size.height)
            ctx.draw(image.cgImage!, in: drawRect)
        }
    }
}
