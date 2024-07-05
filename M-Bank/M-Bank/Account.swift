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
    let number: String
    let card: String
    var transactions: [Transaction]
}
