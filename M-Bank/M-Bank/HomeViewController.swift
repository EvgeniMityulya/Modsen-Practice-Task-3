//
//  ViewController.swift
//  M-Bank
//
//  Created by Anton Polovoy on 26.06.24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var currentAccount: Account! {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.allowsSelection = true
        tv.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        tv.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        return tv
    }()
    
    private let recentTransactionsLabel = TitleLabel(with: "Recent Transactions", ofSize: 28)
    
    private let viewAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("VIEW ALL", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .sfProText(ofSize: 13, style: .regular)
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
    
    private let accountLabel = TitleLabel(with: "Account", ofSize: 28)
    
    private lazy var accountTableViewHeader: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(accountLabel)
        view.axis = .horizontal
        view.alignment = .leading
        view.distribution = .fillProportionally
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad()")
        currentAccount = DataManager.shared.fetchCurrentAccount()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Selectors
    @objc func viewAll() {
        print("Button pressed!")
        let viewController = TransactionsViewController()
        viewController.transactions = currentAccount.transactions
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
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
            if currentAccount.transactions.count < 4 {
                return currentAccount.transactions.count
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
            cell.configure(with: currentAccount, for: .button)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TransactionTableViewCell.identifier,
                for: indexPath
            ) as? TransactionTableViewCell else {
                fatalError("cell did not")
            }
            cell.configure(with: currentAccount.transactions[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? accountTableViewHeader : transactionsTableViewHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = AccountsViewController()
            vc.delegate = self
            presentBottomSheet(viewController: vc)
        } else {
            let vc = TransactionInfoViewController(with: currentAccount.transactions[indexPath.row])
            presentBottomSheet(viewController: vc)
        }
    }
}

extension HomeViewController: AccountsViewControllerDelegate {
    func didSelectAccount(_ account: Account) {
        self.currentAccount = account
    }
}
