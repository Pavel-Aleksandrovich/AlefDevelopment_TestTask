//
//  Color.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 27.10.2022.
//

import UIKit

enum Color {
    case lightBlue
    case red
    
    var color: UIColor {
        switch self {
        case .lightBlue:
            return #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        case .red:
            return .red
        }
    }
}
