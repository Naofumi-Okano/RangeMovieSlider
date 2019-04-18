//
//  RangeMovieSliderTrack.swift
//  RangeMovieSlider
//
//  Created by 岡野 直史 on 2019/04/18.
//  Copyright © 2019年 岡野 直史. All rights reserved.
//

import UIKit
import QuartzCore

class RangeMovieSliderTrack: CALayer {
    weak var rangeSlider: RangeMovieSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            // Clip
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            // Fill the track
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            // Fill the highlighted range
            ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
            let lowerValuePosition = slider.positionForValue(slider.lowerValue).x
            let upperValuePosition = slider.positionForValue(slider.upperValue).x
            if (slider.trackHightInsetLine) {
                let upperRect = CGRect(x: lowerValuePosition - 12, y: 0.0, width: upperValuePosition - lowerValuePosition + 24, height: 2)
                ctx.fill(upperRect)
                let lowerRect = CGRect(x: lowerValuePosition - 12, y: bounds.height - 2, width: upperValuePosition - lowerValuePosition + 24, height: 2)
                ctx.fill(lowerRect)
            } else {
                let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
                ctx.fill(rect)
            }
        }
    }
}
