//
//  ViewController.swift
//  M-Bank
//
//  Created by Anton Polovoy on 26.06.24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let transactions: [Transaction] = [
//        Transaction(company: "OOO \"Company\"", date: "01.06.2024", amount: 10.09, status: .executed),
//        Transaction(company: "OOO \"Company2\"", date: "02.06.2024", amount: 10.09, status: .declined),
//        Transaction(company: "OOO \"Company\"", date: "02.06.2024", amount: 10.09, status: .inProgress),
//        Transaction(company: "OOO \"Company\"", date: "02.06.2024", amount: 10.09, status: .executed),
    ]
    
    private let currentAccount = Account(name: "Saving Account", number: "91212192291221", cardLastDigits: "•••• 1234")
    
    private let transactionTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.allowsSelection = true
        tv.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        tv.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        return tv
    }()
    
    private let recentTransactionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Transactions"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("VIEW ALL", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(viewAll), for: .touchUpInside)
        return button
    }()
    
    private lazy var transactionsTableViewHeader: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(recentTransactionsLabel)
        view.addArrangedSubview(viewAllButton)
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillProportionally
        return view
    }()
    
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "Account"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var accountTableViewHeader: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(accountLabel)
        view.axis = .horizontal
        view.alignment = .leading
        view.distribution = .fillProportionally
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func viewAll() {
        print("Button pressed!")
        let viewController = TransactionsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(transactionTableView)
        self.transactionTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            transactionTableView.topAnchor.constraint(equalTo: view.topAnchor),
            transactionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            transactionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            transactionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if transactions.count < 4 {
                return transactions.count
            } else {
                return 4
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AccountTableViewCell.identifier,
                for: indexPath
            ) as? AccountTableViewCell else {
                fatalError("cell did not")
            }
            cell.configure(with: currentAccount)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TransactionTableViewCell.identifier,
                for: indexPath
            ) as? TransactionTableViewCell else {
                fatalError("cell did not")
            }
            cell.configure(with: transactions[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? accountTableViewHeader : transactionsTableViewHeader
    }
}
