//
//  Extensions.swift
//  stori-ios-challenge
//
//  Created by Daniel Tibaquira on 11/03/24.
//

import Foundation
import UIKit

extension UITableView {
    func registerDefaultCell() {
        register(UINib.init(nibName: Definitions.cellDefaultIdentifier, bundle: nil), forCellReuseIdentifier: Definitions.cellDefaultIdentifier)
    }
    
    func getDefaultCell(indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: Definitions.cellDefaultIdentifier, for: indexPath)
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index]: nil
    }
}

extension UIViewController{
    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
