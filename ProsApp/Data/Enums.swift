//
//  Enums.swift
//  ProsApp
//
//  Created by Gary Harris on 12/7/20.
//

import Foundation
import UIKit
    
public enum RatingsColor {
    case excellent, good, fair

    func toUIColor() -> UIColor {
        switch self {
            case .excellent : return UIColor.systemGreen
            case .good : return UIColor.orange
            case .fair : return UIColor.red
        }
    }
}
