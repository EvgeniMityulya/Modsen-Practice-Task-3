//
//  Transactions.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import Foundation

struct Transactions {
    let transactions: [Transaction]
    
    init() {
        // Date formatter to parse string dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        // Initializing the transactions array
        self.transactions = [
            Transaction(
                company: "Company A",
                number: "12345",
                date: dateFormatter.date(from: "03.07.2024")!,
                status: .executed,
                amount: 150.75
            ),
            Transaction(
                company: "Company B",
                number: "67890",
                date: dateFormatter.date(from: "04.07.2024")!,
                status: .inProgress,
                amount: 200.00
            ),
            Transaction(
                company: "Company C",
                number: "54321",
                date: dateFormatter.date(from: "02.07.2024")!,
                status: .declined,
                amount: 99.99
            ),
            Transaction(
                company: "Company D",
                number: "09876",
                date: dateFormatter.date(from: "01.07.2024")!,
                status: .executed,
                amount: 250.00
            ),
            Transaction(
                company: "Company E",
                number: "11223",
                date: dateFormatter.date(from: "05.07.2024")!,
                status: .inProgress,
                amount: 175.50
            )
        ]
    }
}
