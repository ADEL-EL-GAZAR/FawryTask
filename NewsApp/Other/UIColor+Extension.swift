//
//  UIColor+Extension.swift
//  smow
//
//  Created by Mohamed Tarek on 12/16/18.
//  Copyright © 2018 Madar AlReyadah. All rights reserved.
//

import UIKit

enum AssetsColor {
    case accentColor
    case primary
    case secondary
    case black
    case orange
    case green
    case darkRed
    case darkBlue
    case gray
    case darkGray
    case veryLightGray
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        if (Double("\(UIDevice.current.systemVersion)") ?? 13) <= 12 {
            switch name {
            case .accentColor:
                return #colorLiteral(red: 1.000, green: 0.847, blue: 0.000, alpha: 1.0)
            case .primary:
                return #colorLiteral(red: 0.304, green: 0.662, blue: 0.835, alpha: 1.0)
            case .secondary:
                return #colorLiteral(red: 0.240, green: 0.451, blue: 0.710, alpha: 1.0)
            case .black:
                return UIColor(hexString: "#231F20")
            case .orange:
                return UIColor(hexString: "#F98500")
            case .green:
                return UIColor.green
            case .darkRed:
                return #colorLiteral(red: 0.689, green: 0.076, blue: 0.072, alpha: 1.0)
            case .darkBlue:
                return #colorLiteral(red: 0.137, green: 0.129, blue: 0.361, alpha: 1.0)
            case .darkGray:
                return #colorLiteral(red: 0.620, green: 0.620, blue: 0.620, alpha: 1.0)
            case .gray:
                return #colorLiteral(red: 0.753, green: 0.753, blue: 0.753, alpha: 1.0)
            case .veryLightGray:
                return #colorLiteral(red: 0.938, green: 0.938, blue: 0.938, alpha: 1.0)
            }
        } else {
            switch name {
            case .accentColor:
                return UIColor(named: "AccentColor")
            case .primary:
                return UIColor(named: "primary")
            case .secondary:
                return UIColor(named: "secondary")
            case .black:
                return UIColor(named: "black")
            case .orange:
                return UIColor(named: "orange")
            case .green:
                return UIColor(named: "green")
            case .darkRed:
                return UIColor(named: "darkRed")
            case .darkBlue:
                return UIColor(named: "darkBlue")
            case .darkGray:
                return UIColor(named: "darkGray")
            case .gray:
                return UIColor(named: "gray")
            case .veryLightGray:
                return UIColor(named: "veryLightGray")
            }
        }
    }
    
//    convenience init(hexString: String) {
//        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int = UInt64()
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (255, 0, 0, 0)
//        }
//        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
//    }
}
