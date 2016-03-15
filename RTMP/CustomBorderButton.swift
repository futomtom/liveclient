//
//  CustomBorderButton.swift
//  BorderButton
//
//  Created by Rohit Pathak on 25/11/15.
//  Copyright © 2015 Rohit Pathak. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomBorderButton: UIButton  {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
}