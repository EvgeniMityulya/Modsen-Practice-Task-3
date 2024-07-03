//
//  TransactionInfoViewController.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import UIKit

class TransactionInfoViewController: BottomSheetViewController {
    
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
    
    private let companyLabel = CustomLabel(with: "Transaction was applied in")
    private let numberLabel = CustomLabel(with: "Transaction number")
    private let dateLabel = CustomLabel(with: "Date")
    private let statusLabel = CustomLabel(with: "Transaction status")
    private let amountLabel = CustomLabel(with: "Amount")
    
    private let companyTextField = InfoTextField()
    private let numberTextField = InfoTextField()
    private let dateTextField = InfoTextField()
    private let statusTextField = InfoTextField()
    private let amountTextField = InfoTextField()
    
    private let okayButton = CustomButton(with: "Okay")
    
    // MARK: - Init and setup
    init(with transaction: Transaction) {
        self.transaction = transaction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        okayButton.addTarget(self, action: #selector(handleOkayButton), for: .touchUpInside)
        
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
        
        setContent(content: stackView)
    }
    
    @objc private func handleOkayButton() {
            self.dismissBottomSheet()
    }
}
