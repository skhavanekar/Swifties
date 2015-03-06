//
//  ViewController.swift
//  ColorMaker
//
//  Created by Jason Schatz on 11/2/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redControl: UISwitch!
    @IBOutlet weak var greenControl: UISwitch!
    @IBOutlet weak var blueControl: UISwitch!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeColorComponent(self)
    }
    
    @IBAction func changeColorComponent(sender: AnyObject) {
        
        let r: CGFloat = self.redControl.on ? CGFloat(1.0 * redSlider.value) : 0
        let g: CGFloat = self.greenControl.on ? CGFloat(1.0 * greenSlider.value) : 0
        let b: CGFloat = self.blueControl.on ? CGFloat(1.0 * blueSlider.value) : 0
        
        colorView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    
    
}

