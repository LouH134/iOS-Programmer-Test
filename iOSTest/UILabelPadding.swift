//
//  UILabelPadding.swift
//  iOSTest
//
//  Created by Louis Harris on 5/16/19.
//  Copyright © 2019 D&ATechnologies. All rights reserved.
//

import UIKit

class UILabelPadding: UILabel {
    
    let padding = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
    
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = min(superContentSize.width + padding.left + padding.right, UIScreen.main.bounds.width)
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
