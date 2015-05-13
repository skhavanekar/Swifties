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
        NSShadowAttributeName: MeMeTextFieldDelegate.shadow(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 3.0
    ]
    
    static func shadow() -> NSShadow{
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.redColor()
        return shadow
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
            let defaultText = textField.tag == 1 ? MeMeTextFieldDelegate.topDefaultText:MeMeTextFieldDelegate.bottomDefaultText
            textField.text = defaultText        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}