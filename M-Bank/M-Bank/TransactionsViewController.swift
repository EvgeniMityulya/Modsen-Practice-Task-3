//
//  TransactionsViewController.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 1.07.24.
//

import UIKit

class TransactionsViewController: UIViewController {
    
    // MARK: - Properties
    var transactions: [Transaction] = []
    var filteredTransactions: [Transaction] = []
    var isFiltered = false
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.allowsSelection = true
        tv.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        return tv
    }()
    
    private let moreButton = IconButton(buttonType: .more)
    private let backButton = IconButton(buttonType: .back)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Selectors
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openFilter() {
        let vc = FilterViewController()
        vc.delegate = self
        presentBottomSheet(viewController: vc)
    }
}

extension TransactionsViewController {
    func setupUI() {
        
        view.backgroundColor = .systemBackground
        
        self.navigationItem.title = "All transactions"
        
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(openFilter), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
        
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

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            filteredTransactions.count
        } else {
            transactions.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TransactionTableViewCell.identifier,
            for: indexPath
        ) as? TransactionTableViewCell else {
            fatalError("cell did not")
        }
        if isFiltered {
            cell.configure(with: filteredTransactions[indexPath.row])
            
        } else {
            cell.configure(with: transactions[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TransactionInfoViewController(with: transactions[indexPath.row])
        presentBottomSheet(viewController: vc)
    }
}


extension TransactionsViewController: FilterViewControllerDelegate {
    func filterViewControllerDidSubmit(startDate: Date, endDate: Date) {
        filteredTransactions = transactions.filter { $0.date >= startDate && $0.date <= endDate }
        filteredTransactions.sort { $0.date > $1.date }
        isFiltered = true
        tableView.reloadData()
    }
}
