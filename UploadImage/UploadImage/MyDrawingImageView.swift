//
//  MyDrawingImageView.swift
//  MyImages
//
//  Created by Jan Zelaznog on 8/17/19.
//  Copyright © 2019 Jan Zelaznog. All rights reserved.
//

import UIKit

class MyDrawingImageView: UIView {
    var lastPoint = CGPoint.zero
    var color = UIColor.green
    var brushWidth: CGFloat = 5.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var imageView = UIImageView()
    var tempImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        imageView.frame = CGRect (x:0, y:0, width:self.frame.width, height:self.frame.height)
        self.addSubview(imageView)
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: self.bounds)

        context.move(to: fromPoint)
        context.addLine(to: toPoint)

        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)

        context.strokePath()

        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity

        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        swiped = false // saber si es trazo continuo
        lastPoint = touch.location(in:self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        swiped = true
        let currentPoint = touch.location(in: self)
        drawLine(from: lastPoint, to: currentPoint)
        
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLine(from: lastPoint, to: lastPoint)
        }
        
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.image?.draw(in:self.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView.image?.draw(in:self.bounds, blendMode: .normal, alpha: opacity)
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tempImageView.image = nil
    }

}
