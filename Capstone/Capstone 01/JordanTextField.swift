//
//  JordanTextField.swift
//  Capstone 01
//
//  Created by Rick Bowen on 11/26/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class JordanTextField: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let insetX: CGFloat = 20
    let insetY: CGFloat = 5
    
    // placeholder position
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , insetX , insetY)
    }
    
    // text position
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , insetX , insetY)
    }


}
