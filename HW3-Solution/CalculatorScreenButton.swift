//
//  CalculatorScreenButton.swift
//  HW3-Solution
//
//  Created by Nate on 2/13/20.
//  Copyright © 2020 Jonathan Engelsma. All rights reserved.
//

import UIKit

class CalculatorScreenButton: UIButton {

    override func awakeFromNib() {
        self.backgroundColor = BACKGROUND_COLOR
        self.tintColor = FOREGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.borderColor = BACKGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
    }

}
