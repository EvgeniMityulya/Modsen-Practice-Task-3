//
//  String + Extensions.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 5.07.24.
//

import Foundation

extension String {
    
    func hideCardNumber() -> String {
        guard self.count >= 4 else { return self }
        let lastFour = self.suffix(4)
        return "•••• \(lastFour)"
    }
}
