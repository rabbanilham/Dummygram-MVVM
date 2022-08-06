//
//  UILabel+Extension.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 06/08/22.
//

import UIKit.UILabel

extension UILabel {
    
    enum appFontWeight {
        case light, book, medium, bold, black
    }
    
    func useAppFont(weight: appFontWeight, size: CGFloat) {
        switch weight {
        case .light:
            self.font = UIFont(name: "CircularStd-Light", size: size)
        case .book:
            self.font = UIFont(name: "CircularStd-Book", size: size)
        case .medium:
            self.font = UIFont(name: "CircularStd-Medium", size: size)
        case .bold:
            self.font = UIFont(name: "CircularStd-Bold", size: size)
        case .black:
            self.font = UIFont(name: "CircularStd-Black", size: size)
        }
    }
    
}
