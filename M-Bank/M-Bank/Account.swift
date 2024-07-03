//
//  Account.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 27.06.24.
//

import Foundation

struct Account {
    let id: UUID
    let name: String
    let number: String // 14 digits
    let card: String // 4 digits
    var transactions: [Transaction]
}
