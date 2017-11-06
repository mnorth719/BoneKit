//
//  BorderedButton.swift
//  BoneKit
//
//  Created by Matt  North on 9/29/17.
//

import UIKit

class BorderedButton: UIButton {
    init(frame: CGRect, color: UIColor, disabledColor: UIColor) {
        super.init(frame: frame)
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
        layer.masksToBounds = true
        layer.borderColor = color.cgColor
        self.setTitleColor(color, for: .normal)
        setTitleColor(disabledColor, for: .disabled)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
