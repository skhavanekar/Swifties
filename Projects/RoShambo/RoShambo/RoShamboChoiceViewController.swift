//
//  RoShamboChoiceViewController.swift
//  RoShambo
//
//  Created by Sameer Khavanekar on 3/6/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class RoShamboChoiceViewController: UIViewController {
    var matchHistory:[RPSMatch] = []
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
        
        let match = RPSMatch(player: .Rock, computer: RPS())
        matchHistory.append(match)
        resultViewController.match = match
        
        self.presentViewController(resultViewController, animated: true, completion: nil)
    }

    @IBAction func paperSelected(sender: UIButton) {
        self.performSegueWithIdentifier("onPaperSelected", sender: self)
    }
    @IBAction func showHistory(sender: UIButton) {
        self.performSegueWithIdentifier("showHistory", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showHistory"{
            let historyViewController = segue.destinationViewController as RPSHistoryViewController
            historyViewController.matchHistory = matchHistory
            return
        }
        
        
        let userChoice = segue.identifier == "onPaperSelected" ? RPS.Paper : RPS.Scissors
        if segue.identifier == "onRoshambo" || segue.identifier == "onPaperSelected"{
            let roshamboResultsViewController = segue.destinationViewController as RoShamboResultsViewController
            
            let match = RPSMatch(player: userChoice, computer: RPS())
            matchHistory.append(match)
            roshamboResultsViewController.match = match
            
        }
    }
    
    
}

