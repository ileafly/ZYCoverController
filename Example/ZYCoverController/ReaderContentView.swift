//
//  ReaderContentView.swift
//  ZYCoverController_Example
//
//  Created by luzhiyong on 2019/7/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ReaderContentView: UIView {

    var attributedString: NSMutableAttributedString? {
        didSet {
            drawContent()
        }
    }
    
    private var ctFrame: CTFrame?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawContent() {
        if let attributedString = attributedString {
            let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
            let path = CGPath(rect: self.bounds, transform: nil)
            
            ctFrame = CTFramesetterCreateFrame(framesetter, CFRange(location: 0, length: 0), path, nil)
            
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let context = UIGraphicsGetCurrentContext(), let ctFrame = ctFrame {
            // 反转文字
            // An affine transformation matrix is used to rotate, scale, translate, or skew the objects you draw in a graphics context. The CGAffineTransform type provides functions for creating, concatenating, and applying affine transformations
            let transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: self.bounds.size.height)
            context.concatenate(transform)
            
            CTFrameDraw(ctFrame, context)
        }
    }
    
    

}
