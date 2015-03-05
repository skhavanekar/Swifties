//
//  ViewController.swift
//  Click Counter
//
//  Created by Sameer Khavanekar on 3/5/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var count = 0
    var increment:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        InitUI()
    }
    
    func InitUI(){
        increment = UILabel()
        increment.frame = CGRectMake(150, 150, 60, 60)
        increment.text = "\(0)"
        increment.textColor = UIColor.redColor()
        self.view.addSubview(increment)
        
        var incrementButton = UIButton()
        incrementButton.frame = CGRectMake(150, 200, 60, 60)
        incrementButton.setTitle("Increment", forState: UIControlState.Normal)
        incrementButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.view.addSubview(incrementButton)
        incrementButton.addTarget(self, action: "incrementCount", forControlEvents: UIControlEvents.TouchUpInside)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func incrementCount(){
        count += 1
        increment.text = "\(count)"
    }
}

