//
//  AccountsViewController.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import UIKit

protocol AccountsViewControllerDelegate: AnyObject {
    func didSelectAccount(_ account: Account)
}

class AccountsViewController: BottomSheetViewController {
    
    weak var delegate: AccountsViewControllerDelegate?
    
    // MARK: - Properties
    var accounts: [Account] = []
    var selectedAccount: Int?
    
    // MARK: - UI
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let submitButton = SolidButton(with: "Submit")
    
    let selectAccountLabel = TitleLabel(with: "Select the account", ofSize: 34)
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.allowsSelection = true
        tv.bounces = false
        tv.showsVerticalScrollIndicator = false
        tv.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        accounts = DataManager.shared.fetchAccounts()
        setupUI()
    }
    
    // MARK: - Methods
    private func calculateTableViewHeight() -> CGFloat {
        let height = CGFloat(accounts.count) * (90 + 10)
        if height > view.frame.height {
            return view.frame.height - 200
        }
        return height
    }
    
    // MARK: - Selectors
    @objc func selectAccount() {
        if let selectedAccount = selectedAccount {
            DataManager.shared.setCurrentAccount(index: selectedAccount)
            delegate?.didSelectAccount(accounts[selectedAccount])
            dismissBottomSheet()
        }
    }
}

extension AccountsViewController {
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        contentView.addSubview(selectAccountLabel)
        contentView.addSubview(tableView)
        contentView.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            selectAccountLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            selectAccountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            selectAccountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectAccountLabel.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: selectAccountLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: calculateTableViewHeight()),
            
            submitButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            submitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        submitButton.addTarget(self, action: #selector(selectAccount), for: .touchUpInside)
    }
}


extension AccountsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAccount = indexPath.section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        accounts.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AccountTableViewCell.identifier,
            for: indexPath
        ) as? AccountTableViewCell else {
            fatalError("cell did not")
        }
        cell.configure(with: accounts[indexPath.section], for: .selection)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
}

