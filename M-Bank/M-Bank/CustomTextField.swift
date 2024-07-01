//
//  CustomTextField.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 1.07.24.
//

import UIKit

class CustomTextField: UITextField {

    init(placeholderText: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBackground
        self.isUserInteractionEnabled = false
        self.borderStyle = .roundedRect
        self.placeholder = placeholderText
        self.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let iconImageView = UIImageView(image: UIImage(systemName: "calendar"))
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        
        let iconContainerView: UIView = UIView(frame: 
            CGRect(x: 0, y: 0, width: iconImageView.frame.width + 16, height: iconImageView.frame.height))
        iconImageView.center = iconContainerView.center
        iconContainerView.addSubview(iconImageView)
                
        self.rightView = iconContainerView
        self.rightViewMode = .always
        
        self.layer.borderColor = UIColor.red.cgColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
