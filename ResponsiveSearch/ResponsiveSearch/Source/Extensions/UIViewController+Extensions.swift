//
//  UIViewController+Extensions.swift
//  ResponsiveSearch
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import UIKit

/**
 This extension consist of useful methods that can be used
 to show alerts in a UIViewController.
 */
extension UIViewController {
    
    /// Show alert using an localised error messege
    func showAlert(with error: Error, okAction handler: ((UIAlertAction) -> Void)?=nil) {
        showAlert(message: error.localizedDescription,
                  title: "Error", okAction: handler)
    }
    
    /// Created alert controller for showing alerts/
    func showAlert(message: String?, title: String = "", okAction handler: ((UIAlertAction) -> Void)?=nil ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: (handler != nil) ? handler : { _ in })
        alertController.addAction(okAction)
        alertController.view.tintColor = UIColor.black
        alertController.view.layoutIfNeeded()
        self.present(alertController, animated: true, completion: nil)
    }
}
