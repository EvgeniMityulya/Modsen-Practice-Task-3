//
//  DataManager.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 5.07.24.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private var currentAccount: Int = 0
    
    func setCurrentAccount(index: Int) {
        currentAccount = index
    }
    
    let accounts = [
        Account(
            id: UUID(),
            name: "John Doe",
            number: "12345678901234",
            card: "1234567890123456",
            transactions: [
                Transaction(company: "Amazon", number: "123456789012", date: Date().addingTimeInterval(-86400 * 10), status: .executed, amount: 150.75),
                Transaction(company: "Apple", number: "234567890123", date: Date().addingTimeInterval(-86400 * 5), status: .declined, amount: 200.50),
                Transaction(company: "Microsoft", number: "345678901234", date: Date().addingTimeInterval(-86400 * 2), status: .inProgress, amount: 300.00),
                Transaction(company: "Google", number: "456789012345", date: Date().addingTimeInterval(-86400 * 1), status: .executed, amount: 250.75),
                Transaction(company: "Netflix", number: "567890123456", date: Date(), status: .executed, amount: 15.99),
                Transaction(company: "Spotify", number: "678901234567", date: Date().addingTimeInterval(-86400 * 7), status: .declined, amount: 9.99),
                Transaction(company: "Amazon", number: "789012345678", date: Date().addingTimeInterval(-86400 * 3), status: .executed, amount: 99.99),
                Transaction(company: "Apple", number: "890123456789", date: Date().addingTimeInterval(-86400 * 4), status: .inProgress, amount: 199.99),
                Transaction(company: "Amazon", number: "901234567890", date: Date().addingTimeInterval(-86400 * 8), status: .executed, amount: 49.99),
                Transaction(company: "Google", number: "012345678901", date: Date().addingTimeInterval(-86400 * 6), status: .executed, amount: 150.00)
            ]
        ),
        Account(
            id: UUID(),
            name: "Jane Smith",
            number: "98765432109876",
            card: "6543210987654321",
            transactions: [
                Transaction(company: "Ebay", number: "345678901234", date: Date().addingTimeInterval(-86400 * 15), status: .executed, amount: 75.00),
                Transaction(company: "Best Buy", number: "456789012345", date: Date().addingTimeInterval(-86400 * 12), status: .executed, amount: 120.30),
                Transaction(company: "Walmart", number: "567890123456", date: Date().addingTimeInterval(-86400 * 11), status: .inProgress, amount: 85.50),
                Transaction(company: "Target", number: "678901234567", date: Date().addingTimeInterval(-86400 * 9), status: .declined, amount: 95.25),
                Transaction(company: "Best Buy", number: "789012345678", date: Date().addingTimeInterval(-86400 * 14), status: .executed, amount: 220.75),
                Transaction(company: "Ebay", number: "890123456789", date: Date().addingTimeInterval(-86400 * 13), status: .executed, amount: 110.00),
                Transaction(company: "Walmart", number: "901234567890", date: Date().addingTimeInterval(-86400 * 10), status: .declined, amount: 65.50),
                Transaction(company: "Target", number: "012345678901", date: Date().addingTimeInterval(-86400 * 8), status: .inProgress, amount: 100.25),
                Transaction(company: "Ebay", number: "123456789012", date: Date().addingTimeInterval(-86400 * 6), status: .executed, amount: 175.00),
                Transaction(company: "Best Buy", number: "234567890123", date: Date().addingTimeInterval(-86400 * 4), status: .executed, amount: 320.30)
            ]
        ),
        Account(
            id: UUID(),
            name: "Alice Johnson",
            number: "11223344556677",
            card: "1122334455667788",
            transactions: [
                Transaction(company: "Target", number: "567890123456", date: Date().addingTimeInterval(-86400 * 20), status: .declined, amount: 90.25),
                Transaction(company: "Walmart", number: "678901234567", date: Date().addingTimeInterval(-86400 * 18), status: .executed, amount: 45.50),
                Transaction(company: "Home Depot", number: "789012345678", date: Date().addingTimeInterval(-86400 * 16), status: .inProgress, amount: 120.75),
                Transaction(company: "Lowe's", number: "890123456789", date: Date().addingTimeInterval(-86400 * 14), status: .executed, amount: 89.99),
                Transaction(company: "Target", number: "901234567890", date: Date().addingTimeInterval(-86400 * 12), status: .executed, amount: 130.25),
                Transaction(company: "Walmart", number: "012345678901", date: Date().addingTimeInterval(-86400 * 10), status: .declined, amount: 50.00),
                Transaction(company: "Home Depot", number: "123456789012", date: Date().addingTimeInterval(-86400 * 8), status: .executed, amount: 200.00),
                Transaction(company: "Lowe's", number: "234567890123", date: Date().addingTimeInterval(-86400 * 6), status: .executed, amount: 75.75),
                Transaction(company: "Target", number: "345678901234", date: Date().addingTimeInterval(-86400 * 4), status: .inProgress, amount: 110.00),
                Transaction(company: "Walmart", number: "456789012345", date: Date().addingTimeInterval(-86400 * 2), status: .executed, amount: 60.50)
            ]
        )
    ]

    func fetchCurrentAccount() -> Account {
        return accounts[self.currentAccount]
    }
    
    func fetchAccounts() -> [Account] {
        return accounts
    }
}
