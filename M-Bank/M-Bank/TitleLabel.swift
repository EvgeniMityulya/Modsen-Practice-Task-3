//
//  TitleLabel.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import UIKit

class TitleLabel: UILabel {

    init(with text: String, ofSize size: CGFloat = 28) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = .white
        self.font = UIFont.sfProDisplay(ofSize: size, style: .bold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
