//
//  Accounts.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 4.07.24.
//

import Foundation

struct Accounts {
    
    init() {
        // Directly initialize mock accounts
        self.accounts = [
            Account(
                id: UUID(),
                name: "John Doe",
                number: "12345678901234",
                card: "1234567890123456",
                transactions: [
                    Transaction(company: "Amazon", number: "123456789012", date: Date(), status: .executed, amount: 150.75),
                    Transaction(company: "Apple", number: "234567890123", date: Date(), status: .declined, amount: 200.50)
                ]
            ),
            Account(
                id: UUID(),
                name: "Jane Smith",
                number: "23456789012345",
                card: "2345678901234567",
                transactions: [
                    Transaction(company: "Google", number: "345678901234", date: Date(), status: .inProgress, amount: 300.00),
                    Transaction(company: "Microsoft", number: "456789012345", date: Date(), status: .executed, amount: 450.25),
                    Transaction(company: "Netflix", number: "567890123456", date: Date(), status: .executed, amount: 99.99)
                ]
            ),
            Account(
                id: UUID(),
                name: "Alice Johnson",
                number: "34567890123456",
                card: "3456789012345678",
                transactions: [
                    Transaction(company: "Spotify", number: "678901234567", date: Date(), status: .inProgress, amount: 12.99)
                ]
            )
        ]
    }
    
    var accounts: [Account]
    
//    var currentAccount: UUID
    
    var numberOfAccounts: Int {
        return accounts.count
    }
    
    func account(at index: Int) -> Account? {
        guard index >= 0 && index < accounts.count else { return nil }
        return accounts[index]
    }
    
    mutating func add(_ account: Account) {
        accounts.append(account)
    }
}




struct MockDataGenerator {
    var mockAccounts: [Account]
    
    init(accountCount: Int) {
        self.mockAccounts = Self.generateMockAccounts(count: accountCount)
    }
    
    // Helper function to generate a random string of digits with a specified length
    static func randomDigits(length: Int) -> String {
        return String((0..<length).map { _ in Int.random(in: 0...9) }.reduce(0) { $0 * 10 + $1 })
    }
    
    // Helper function to generate a random date within the last year
    static func randomDate() -> Date {
        let days = Int.random(in: 0...365)
        return Calendar.current.date(byAdding: .day, value: -days, to: Date())!
    }
    
    // Helper function to generate a random transaction status
    static func randomTransactionStatus() -> TransactionStatus {
        let statuses: [TransactionStatus] = [.executed, .declined, .inProgress]
        return statuses.randomElement()!
    }
    
    // Generate mock transactions
    static func generateMockTransactions(count: Int) -> [Transaction] {
        let companies = ["Amazon", "Apple", "Google", "Microsoft", "Netflix"]
        return (0..<count).map { _ in
            Transaction(
                company: companies.randomElement()!,
                number: randomDigits(length: 12),
                date: randomDate(),
                status: randomTransactionStatus(),
                amount: Float.random(in: 10...1000)
            )
        }
    }
    
    // Generate mock accounts
    static func generateMockAccounts(count: Int) -> [Account] {
        return (0..<count).map { _ in
            Account(
                id: UUID(),
                name: ["John Doe", "Jane Smith", "Alice Johnson"].randomElement()!,
                number: randomDigits(length: 14),
                card: randomDigits(length: 16),
                transactions: generateMockTransactions(count: Int.random(in: 1...5))
            )
        }
    }
}
