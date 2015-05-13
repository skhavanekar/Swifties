//
//  ViewController.swift
//  Data Structures
//
//  Created by Sameer Khavanekar on 5/7/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var sampleArray = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        println(Search.BinarySearch(sampleArray, searchKey: 6, low: 0, high: sampleArray.count-1))
        println(Search.BinarySearch(sampleArray, searchKey: 1, low: 0, high: sampleArray.count-1))
        println(Search.BinarySearch(sampleArray, searchKey: 9, low: 0, high: sampleArray.count-1))
        println(Search.BinarySearch(sampleArray, searchKey: 10, low: 0, high: sampleArray.count-1))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

