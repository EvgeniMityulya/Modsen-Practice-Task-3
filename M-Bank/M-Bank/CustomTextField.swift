//
//  CustomTextField.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 1.07.24.
//

import UIKit

class CustomTextField: UITextField {

    init(with text: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .black
        self.isUserInteractionEnabled = true
        self.borderStyle = .roundedRect
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.cornerRadius = 10
        self.placeholder = text
        self.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
//        let iconImageView = UIImageView(image: UIImage(systemName: "calendar"))
//        iconImageView.tintColor = .white
//        iconImageView.contentMode = .scaleAspectFit
//        
//        let iconContainerView: UIView = UIView(frame: 
//            CGRect(x: 0, y: 0, width: iconImageView.frame.width + 16, height: iconImageView.frame.height))
//        iconImageView.center = iconContainerView.center
//        iconContainerView.addSubview(iconImageView)
//                
//        self.rightView = iconContainerView
//        self.rightViewMode = .always
    }

    func setRedBorder() {
        layer.borderColor = UIColor.systemRed.cgColor
    }
    
    func setWhiteBorder() {
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
