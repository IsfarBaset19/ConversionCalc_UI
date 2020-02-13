//
//  CalculatorScreenUITextField.swift
//  HW3-Solution
//
//  Created by Nate on 2/13/20.
//  Copyright © 2020 Jonathan Engelsma. All rights reserved.
//

import UIKit

class CalculatorScreenUITextField: DecimalMinusTextField {

    override func awakeFromNib() {
        self.tintColor = FOREGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
        
        self.textColor = FOREGROUND_COLOR
        self.backgroundColor = UIColor.clear
        self.borderStyle = .roundedRect
        
        guard let ph = self.placeholder else{
            return
        }
        
        self.attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSAttributedString.Key.foregroundColor : FOREGROUND_COLOR])
    }

}
