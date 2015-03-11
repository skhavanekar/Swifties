//
//  RoShamboResultsViewController.swift
//  RoShambo
//
//  Created by Sameer Khavanekar on 3/6/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class RoShamboResultsViewController: UIViewController {
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    
    var match:RPSMatch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var victoryMessage = ""
        var (result, imageName) = ("", "")
        if match.player == match.computer{
            victoryMessage = "Tie..."
            (result, imageName) = match.player.victoryData(match.computer)
        }else if match.player.defeats(match.computer){
            victoryMessage = "You win!"
            (result, imageName) = match.player.victoryData(match.computer)
        }else{
            victoryMessage = "You lose!"
            (result, imageName) = match.computer.victoryData(match.player)
        }
        
        self.result.text = victoryMessage+" "+result
        resultImage.image = UIImage(named: imageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAgain(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
