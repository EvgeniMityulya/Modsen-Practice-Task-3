//
//  TransactionInfoViewController.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import UIKit

class TransactionInfoViewController: BottomSheetViewController {
    
    // MARK: - Properties
    var transaction: Transaction
    
    // MARK: - UI
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let transactionLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Transactions"
        label.textColor = .white
        label.font = UIFont.sfProDisplay(ofSize: 28, style: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let companyLabel = TextLabel(with: "Transaction was applied in")
    private let numberLabel = TextLabel(with: "Transaction number")
    private let dateLabel = TextLabel(with: "Date")
    private let statusLabel = TextLabel(with: "Transaction status")
    private let amountLabel = TextLabel(with: "Amount")
    
    private let companyTextField = InfoTextField()
    private let numberTextField = InfoTextField()
    private let dateTextField = InfoTextField()
    private let statusTextField = InfoTextField()
    private let amountTextField = InfoTextField()
    
    private let okayButton = SolidButton(with: "Okay")
    
    // MARK: - Lifecycle
    init(with transaction: Transaction) {
        self.transaction = transaction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTargets()
    }
    
    // MARK: - Selectors
    @objc private func handleOkayButton() {
        self.dismissBottomSheet()
    }
}

private extension TransactionInfoViewController {
    
    func setupTargets() {
        okayButton.addTarget(self, action: #selector(handleOkayButton), for: .touchUpInside)
    }
    
    func setupUI() {
        companyTextField.text = transaction.company
        numberTextField.text = transaction.number
        dateTextField.text = transaction.date.toString()
        statusTextField.text = transaction.status.toString()
        amountTextField.text = "$\(transaction.amount)"
        
        stackView.addArrangedSubview(
            transactionLabel,
            companyLabel,
            companyTextField,
            numberLabel,
            numberTextField,
            dateLabel,
            dateTextField,
            statusLabel,
            statusTextField,
            amountLabel,
            amountTextField,
            okayButton
        )
        
        stackView.setCustomSpacing(50, after: amountTextField)
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}


