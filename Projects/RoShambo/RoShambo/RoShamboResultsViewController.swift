//
//  RoShamboResultsViewController.swift
//  RoShambo
//
//  Created by Sameer Khavanekar on 3/6/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class RoShamboResultsViewController: UIViewController {
    var computersChoice:Roshambo?
    var usersChoice:Roshambo?
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let usersChoiceValue = usersChoice?{
            if let computerChoiceValue = computersChoice?{
                let (message, imageName) = Roshambo.winner(usersChoiceValue, computerChoice: computerChoiceValue)
                self.result.text = message
                resultImage.image = UIImage(named: imageName)
            }
        }else{
            self.result.text = "Data invalid!"
        }
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
