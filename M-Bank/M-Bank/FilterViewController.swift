//
//  FilterViewController.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 1.07.24.
//

import UIKit

class FilterViewController: UIViewController {
    
    private let filterByDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Transactions"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Date"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Date"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startDate: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let textField = CustomTextField(placeholderText: "Select start date")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension FilterViewController {
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
    
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(
            filterByDateLabel,
            startDateLabel,
            textField
        )
                
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
        ])
    }
}
