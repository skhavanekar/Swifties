//
//  RPSHistoryViewController.swift
//  RoShambo
//
//  Created by Sameer Khavanekar on 3/10/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class RPSHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var matchHistory:[RPSMatch]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("winnerRPS") as UITableViewCell
        
        var match = matchHistory[indexPath.row]
        var (result, imageName) = match.result
        cell.textLabel?.text = result
        cell.imageView?.image = UIImage(named: imageName)
        return cell
    }

    
    // MARK: - DATA SOURCE
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return matchHistory.count
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
