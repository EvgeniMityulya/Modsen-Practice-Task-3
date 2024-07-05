//
//  UIButton.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 1.07.24.
//

import UIKit

class IconButton: UIButton {
    
    enum ButtonType: String {
        case back = "chevron.left"
        case more = "ellipsis.circle"
        case calendar = "calendar"
    }

    init(buttonType: ButtonType) {
        super.init(frame: .zero)
        
        self.setImage(UIImage(systemName: buttonType.rawValue), for: .normal)
        self.backgroundColor = .clear
        self.tintColor = .label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
