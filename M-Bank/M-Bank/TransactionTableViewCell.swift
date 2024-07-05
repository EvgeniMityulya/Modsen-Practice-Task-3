//
//  TransactionTableViewCell.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 27.06.24.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: TransactionTableViewCell.self)
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.heightAnchor.constraint(equalToConstant: 22).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.heightAnchor.constraint(equalToConstant: 18).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.heightAnchor.constraint(equalToConstant: 18).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chevronImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let stackView2 = UIStackView(arrangedSubviews: [companyLabel, amountLabel, chevronImageView])
        stackView2.axis = .horizontal
        stackView2.alignment = .fill
        stackView2.spacing = 2
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [stackView2, dateLabel, statusLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 2
//        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
            
        contentView.addSubview(stackView)
            
        NSLayoutConstraint.activate([
            stackView2.heightAnchor.constraint(equalToConstant: 22),
            
            stackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(with transaction: Transaction) {
            companyLabel.text = transaction.company
            dateLabel.text = transaction.date.toString()
            amountLabel.text = "$\(transaction.amount)"
            statusLabel.text = transaction.status.toString()
            statusLabel.textColor = transaction.status.color()
        }
}
