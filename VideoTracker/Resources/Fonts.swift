//
//  Fonts.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 17.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit


extension UIFont {
    static func primary(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let fontName: String!
        
        switch weight {
        case .regular:
            fontName = "Roboto-Regular"
        case .medium:
            fontName = "Roboto-Medium"
        case .bold:
            fontName = "Roboto-Bold"
        case .black:
            fontName = "Roboto-Black"
        case .ultraLight:
            fontName = "Roboto-Ultra"
        default:
            fontName = "Roboto-Bold"
        }
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
