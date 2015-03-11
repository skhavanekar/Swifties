//
//  CurrencyTextFieldDelegate.swift
//  TextFields
//
//  Created by Sameer Khavanekar on 3/9/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation
import UIKit

class CurrencyTextFieldDelegate: NSObject, UITextFieldDelegate {
    let defaultFormat = "$0.00"
    var enteredNumber:Double = 0.0
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var newRange:NSRange
        if string.isEmpty{
            return true
        }
        var number = String.toInt(string)
        if number() == nil{
            return false
        }
        var newText = textField.text as NSString
        var currentNumber:Int = number()!
        
        enteredNumber = enteredNumber * 10 + Double(currentNumber) * 0.01
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        println()
        
        
        textField.text = formatter.stringFromNumber(enteredNumber)
        println(newText)
        return false
    }
    
}