//
//  Labels.swift
//  ProsApp
//
//  Created by Gary Harris on 12/6/20.
//
import Foundation
import UIKit


class RatingsLabel : UILabel {
    
    func setRatingText(rating: String, ratingCount: String) {

        let ratingFloat = Float(rating) ?? 0
        let ratingCountInt = Int(ratingCount) ?? 0
        var ratingsColor = UIColor { tc in
            switch tc.userInterfaceStyle {
            case .dark:
                return DefaultTextColor.white.toUIColor()
            default:
                return DefaultTextColor.black.toUIColor()
            }
        }

        let displayText = ratingCountInt > 0 ?
            "Ratings: \(rating) | \(ratingCount)" :
            "References Available"
    
        if ratingCountInt > 0 {
            if ratingFloat >= 4.0 {
                ratingsColor = RatingsColor.excellent.toUIColor()
            } else if ratingFloat >= 3.0 && ratingFloat < 4.0 {
                ratingsColor = RatingsColor.good.toUIColor()
            } else if ratingFloat < 3.0 {
                ratingsColor = RatingsColor.fair.toUIColor()
            }
        }
        
        self.textColor = ratingsColor
        self.text = displayText

    }

}
