//
//  ViewController.swift
//  Image Magic
//
//  Created by Sameer Khavanekar on 4/13/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        pickImageFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
        
    }
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        pickImageFromSource(UIImagePickerControllerSourceType.Camera)
    }
    
    func pickImageFromSource(sourceType:UIImagePickerControllerSourceType){
        let imagePick = UIImagePickerController();
        imagePick.delegate = self
        imagePick.sourceType = sourceType
        self.presentViewController(imagePick, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

