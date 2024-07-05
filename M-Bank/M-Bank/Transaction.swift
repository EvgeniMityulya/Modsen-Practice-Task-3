//
//  Transaction.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 27.06.24.
//

import Foundation
import UIKit

enum TransactionStatus {
    case executed
    case declined
    case inProgress
    
    func toString() -> String {
        switch self {
        case .executed: return "Executed"
        case .declined: return "Declined"
        case .inProgress: return "In Progress"
        }
    }
    
    func color() -> UIColor {
        switch self {
        case .executed: return UIColor.systemGreen
        case .declined: return UIColor.systemRed
        case .inProgress: return UIColor.systemYellow
        }
    }
}

struct Transaction {
    let company: String
    let number: String
    let date: Date
    let status: TransactionStatus
    let amount: Float
}
