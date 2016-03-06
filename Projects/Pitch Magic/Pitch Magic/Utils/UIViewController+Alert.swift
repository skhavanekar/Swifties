//
//  UIViewController+Alert.swift
//  Pitch Magic
//
//  Created by Sameer Khavanekar on 3/6/16.
//  Copyright © 2016 Sameer Khavanekar. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title:"Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
        }
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
