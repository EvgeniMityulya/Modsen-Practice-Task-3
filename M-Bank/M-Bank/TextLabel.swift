//
//  CustomLabel.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 2.07.24.
//

import UIKit

class TextLabel: UILabel {

    init(with text: String) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = .white
        self.font = UIFont.sfProText(ofSize: 17, style: .regular)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
