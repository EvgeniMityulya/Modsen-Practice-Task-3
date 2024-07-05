//
//  AccountTableViewCell.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 27.06.24.
//

import UIKit

enum CellPurpose {
    case button
    case selection
}

class AccountTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: AccountTableViewCell.self)

    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appleCard")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let accountNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let accountNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let chevronImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(with account: Account, for purpose: CellPurpose) {
        self.accountNameLabel.text = account.name
        self.accountNumberLabel.text = account.number
        self.cardNumberLabel.text = account.card.hideCardNumber()
        
        if purpose == .selection {
            chevronImageView.isHidden = true
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(named: "selection")
            selectedBackgroundView = backgroundView
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.detailsStackView.addArrangedSubview(
            self.accountNameLabel,
            self.accountNumberLabel,
            self.cardNumberLabel
        )
        
        self.contentView.addSubview(cardImageView)
        self.contentView.addSubview(detailsStackView)
        self.contentView.addSubview(chevronImageView)
        
        NSLayoutConstraint.activate([
            self.cardImageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.cardImageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.cardImageView.widthAnchor.constraint(equalToConstant: 40),
            self.cardImageView.heightAnchor.constraint(equalToConstant: 25),
            
            self.detailsStackView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.detailsStackView.leadingAnchor.constraint(equalTo: self.cardImageView.trailingAnchor, constant: 10),
            self.detailsStackView.heightAnchor.constraint(equalToConstant: 60),
            
            self.chevronImageView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.chevronImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
