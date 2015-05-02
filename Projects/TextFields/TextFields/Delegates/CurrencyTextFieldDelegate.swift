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
        var newText = textField.text as NSString
        if string.isEmpty{
            var myNumber = newText.substringFromIndex(1) as NSString
            myNumber = myNumber.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: ","))
            
            println("\(myNumber) to \(myNumber.doubleValue)")
            if myNumber.doubleValue > 0.0{
                formatTexfield(textField, enteredNumber: myNumber.doubleValue)
                return false
            }
            return true
        }
        var number = String.toInt(string)
        if number() == nil{
            return false
        }
        
        var currentNumber:Int = number()!
        
        enteredNumber = enteredNumber * 10 + Double(currentNumber) * 0.01
        formatTexfield(textField, enteredNumber: enteredNumber)
        return false
    }
    
    func formatTexfield(textField:UITextField, enteredNumber:Double){
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        textField.text = formatter.stringFromNumber(enteredNumber)
    }
    
}