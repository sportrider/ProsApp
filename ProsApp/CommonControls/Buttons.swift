//
//  Buttons.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import Foundation
import UIKit


class OrangeButton : UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.layer.borderWidth = 0.0
        self.layer.backgroundColor = UIColor(red: 0.97, green: 0.56, blue: 0.12, alpha: 1.00).cgColor
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func setTitleText(_ title: String) {

        let labelFont = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        let attributes :Dictionary = [NSAttributedString.Key.font : labelFont, NSAttributedString.Key.foregroundColor : UIColor.white]
        let attrString = NSAttributedString(string: title, attributes:attributes as [NSAttributedString.Key : Any])

        self.setAttributedTitle(attrString, for: .normal)

    }

}
