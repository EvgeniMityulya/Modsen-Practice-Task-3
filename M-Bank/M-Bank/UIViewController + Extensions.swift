//
//  UIViewController + Extensions.swift
//  M-Bank
//
//  Created by Denis Haritonenko on 3.07.24.
//

import Foundation
import UIKit

extension UIViewController {
    func presentBottomSheet(viewController: BottomSheetViewController) {
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: false, completion: nil)
    }
}
