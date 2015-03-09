//
//  TextFieldViewController.swift
//  TextFields
//
//  Created by Sameer Khavanekar on 3/9/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController {
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var currency: UITextField!
    @IBOutlet weak var normalText: UITextField!
    @IBOutlet weak var editNormalText: UISwitch!

    let zipCodeDelegate = ZipcodeTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        zipcode.delegate = zipCodeDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enableNormalTextEditing(sender: UISwitch) {
        normalText.enabled = sender.on
        if !normalText.enabled{
            normalText.resignFirstResponder()
        }
    }

}

