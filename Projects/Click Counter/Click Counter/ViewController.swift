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
    var decrementedCount = 0
    
    var increment:UILabel!
    var decrement:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        InitUI()
    }
    
    func InitUI(){
        increment = makeLabelAt(CGRectMake(150, 150, 60, 60))
        decrement = makeLabelAt(CGRectMake(250, 150, 60, 60))
        
        makeButtonAt(CGRectMake(150, 200, 60, 60), withLabel: "Click", forSelector: "incrementCount")
        makeButtonAt(CGRectMake(250, 200, 60, 60), withLabel: "D-Click", forSelector: "decrementCount")
        makeButtonAt(CGRectMake(200, 280, 60, 60), withLabel: "Color", forSelector: "changeBackground")
    }
    
    func makeButtonAt(position:CGRect, withLabel:String, forSelector:Selector) -> UIButton{
        var nextButton = UIButton()
        nextButton.frame = position
        nextButton.setTitle(withLabel, forState: UIControlState.Normal)
        nextButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.view.addSubview(nextButton)
        nextButton.addTarget(self, action: forSelector, forControlEvents: UIControlEvents.TouchUpInside)
        return nextButton
    }
    
    func makeLabelAt(position:CGRect) -> UILabel{
        var nextLabel = UILabel()
        nextLabel.frame = position
        nextLabel.text = "0"
        nextLabel.textColor = UIColor.redColor()
        self.view.addSubview(nextLabel)
        return nextLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func incrementCount(){
        count += 1
        decrementedCount += 1
        increment.text = "\(count)"
        decrement.text = "\(decrementedCount)"
    }
    
    func decrementCount(){
        decrementedCount -= 1
        decrement.text = "\(decrementedCount)"
    }
    
    func changeBackground(){
        self.view.backgroundColor = randomColor()
    }
    
    func randomColor() -> UIColor{
        return UIColor(red: randomFloat(), green: randomFloat(), blue: randomFloat(), alpha: 1)
    }
    
    func randomFloat() -> CGFloat{
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
}

