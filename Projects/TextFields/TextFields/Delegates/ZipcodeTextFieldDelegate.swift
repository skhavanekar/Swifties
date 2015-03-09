//
//  ZipcodeTextFieldDelegate.swift
//  TextFields
//
//  Created by Sameer Khavanekar on 3/9/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation
import UIKit

class ZipcodeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty{
            return true
        }
        var newText = textField.text as NSString
        //println("range \(range.length):\(range.location) replacement: \(string)")
        if range.location >= 5{
            return false
        }
        let number = String.toInt(string)
        
        if number() == nil{
            return false
        }
        
        println(newText)
        return true
    }
}