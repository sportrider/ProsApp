//
//  Extensions.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import Foundation
import UIKit

extension UIColor {
    
  struct RatingsColor {
    static var excellent: UIColor { return UIColor.systemGreen }
    static var good: UIColor { return UIColor.orange }
    static var fair: UIColor { return UIColor.red }
  }
    
}

extension UILabel {
    
   public func displayRating(rating: String, ratingCount: String) -> Void {
        
        let ratingFloat = Float(rating) ?? 0
        let ratingCountInt = Int(ratingCount) ?? 0
        var ratingsColor = UIColor.black

        let displayText = ratingCountInt > 0 ?
            "Ratings: \(rating) | \(ratingCount)" :
            "References Available"
    
        if ratingCountInt > 0 {
            if ratingFloat >= 4.0 {
                ratingsColor = UIColor.RatingsColor.excellent
            } else if ratingFloat >= 3.0 && ratingFloat < 4.0 {
                ratingsColor = UIColor.RatingsColor.good
            } else if ratingFloat < 3.0 {
                ratingsColor = UIColor.RatingsColor.fair
            }
        }
        
        self.textColor = ratingsColor
        self.text = displayText
    }
    
}
