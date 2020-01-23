//
//  UIViewController+Extensions.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/23/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alert = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alert)
        present(alertController, animated: true)
    }
}
