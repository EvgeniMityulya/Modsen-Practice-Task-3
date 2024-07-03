//
//  UIFont + Extensions.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import Foundation
import UIKit

enum SFProTextStyle: String {
    case regular = "SFProText-Regular"
}

enum SFProDisplayStyle: String {
    case bold = "SFProDisplay-Bold"
}

extension UIFont {
    static func sfProText(ofSize size: CGFloat, style: SFProTextStyle) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
    static func sfProDisplay(ofSize size: CGFloat, style: SFProDisplayStyle) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
