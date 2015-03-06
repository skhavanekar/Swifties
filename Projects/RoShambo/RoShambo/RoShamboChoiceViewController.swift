//
//  RoShamboChoiceViewController.swift
//  RoShambo
//
//  Created by Sameer Khavanekar on 3/6/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class RoShamboChoiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //programmatic segue transition example here
    @IBAction func rockSelected(sender: UIButton) {
        var resultViewController:RoShamboResultsViewController
        
        resultViewController = self.storyboard?.instantiateViewControllerWithIdentifier("resultsViewController") as RoShamboResultsViewController
        
        resultViewController.usersChoice = Roshambo.Rock
        resultViewController.computersChoice = Roshambo.random()

        self.presentViewController(resultViewController, animated: true, completion: nil)
    }

    @IBAction func paperSelected(sender: UIButton) {
        self.performSegueWithIdentifier("onPaperSelected", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let userChoice = segue.identifier == "onPaperSelected" ? Roshambo.Paper : Roshambo.Scissors
        
        
        if segue.identifier == "onRoshambo" || segue.identifier == "onPaperSelected"{
            let roshamboResultsViewController = segue.destinationViewController as RoShamboResultsViewController
            roshamboResultsViewController.usersChoice = userChoice
            roshamboResultsViewController.computersChoice = Roshambo.random()
        }
    }
    
    
}

