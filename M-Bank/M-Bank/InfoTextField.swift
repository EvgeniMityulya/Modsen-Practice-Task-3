//
//  InfoTextField.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import UIKit

class InfoTextField: UITextField {

    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBackground
        self.isUserInteractionEnabled = false
        self.borderStyle = .roundedRect
        self.textColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 8
        self.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setText(_ text: String) {
        self.text = text
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
