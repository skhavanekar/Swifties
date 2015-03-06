//
//  ViewController.swift
//  UI Experiments
//
//  Created by Sameer Khavanekar on 3/6/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showImagePicker(sender: UIButton) {
        let nextViewController = UIImagePickerController()
        self.presentViewController(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func showActivityView(sender: UIButton) {
        let sharedImage = UIImage()
        let nextViewController = UIActivityViewController(activityItems: [sharedImage], applicationActivities: nil)
        self.presentViewController(nextViewController, animated: true, completion: nil)
    }

    @IBAction func showAlert(sender: UIButton) {
        let nextViewController = UIAlertController(title: "Test Alert", message: "Isn't this awesome?", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            action in self.dismissViewControllerAnimated(true, completion: nil)
        })
        nextViewController.addAction(okAction)
        self.presentViewController(nextViewController, animated: true, completion: nil)
    }
}

