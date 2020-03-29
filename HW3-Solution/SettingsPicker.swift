//
//  SettingsPicker.swift
//  HW3-Solution
//
//  Created by Isfar Baset on 2/20/20.
//  Copyright © 2020 Jonathan Engelsma. All rights reserved.
//

import UIKit

class SettingsPicker: UIPickerView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = PICKER_COLOR
        //self.tintColor = FOREGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.borderColor = PICKER_COLOR.cgColor
        self.layer.cornerRadius = 5.0
    }

}

