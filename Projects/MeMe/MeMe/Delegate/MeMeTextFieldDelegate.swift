//
//  MeMeTextFieldDelegate.swift
//  MeMe
//
//  Created by Sameer Khavanekar on 4/13/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation
import UIKit

class MeMeTextFieldDelegate: NSObject, UITextFieldDelegate {
    static let topDefaultText = "TOP"
    static let bottomDefaultText = "BOTTOM"
    
    static let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 3.0
    ]
    
    override init() {
        super.init()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    // MARK: - TextField Delegation
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == MeMeTextFieldDelegate.topDefaultText || textField.text == MeMeTextFieldDelegate.bottomDefaultText{
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text == ""{
            textField.text = textField.placeholder!
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}