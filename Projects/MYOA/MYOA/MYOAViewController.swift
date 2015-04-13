//
//  MYOAViewController.swift
//  MYOA
//
//  Created by Sameer Khavanekar on 3/26/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class MYOAViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Over", style: UIBarButtonItemStyle.Plain, target: self, action: "startOver")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startOver(){
        if let navigationController = self.navigationController?{
            navigationController.popToRootViewControllerAnimated(true)
        }
    }
    
    deinit{
        println("Deinitialized...")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
