//
//  RatingColors.swift
//  YametKudasiMovie
//
//  Created by AkbarPuteraW on 19/09/21.
//

import UIKit

enum Ratings {
    case bad
    case normal
    case good
    case excellent
    
    var desc: UIColor {
        switch self {
        case .bad:
            return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case .normal:
            return #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        case .good:
            return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        case .excellent:
            return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
    }
    
    
    static func ratingScore(rating: Float) -> Ratings {
        switch rating {
        case ...5.0:
            return .bad
        case 5.1...7.0:
            return .normal
        case 7.0...8.0:
            return .good
        default:
            return .excellent
        }
    }
}
