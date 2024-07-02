//
//  CustomButton.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 2.07.24.
//

import UIKit

class CustomButton: UIButton {
    
    init(with title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = .systemBlue
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        self.layer.cornerRadius = 10
        self.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
