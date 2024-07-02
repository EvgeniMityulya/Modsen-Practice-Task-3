//
//  CustomLabel.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 2.07.24.
//

import UIKit

class CustomLabel: UILabel {

    init(with text: String) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
