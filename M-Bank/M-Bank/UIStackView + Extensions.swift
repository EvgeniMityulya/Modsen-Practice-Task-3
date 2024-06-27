//
//  UIStackView + Extensions.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 27.06.24.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubview(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
