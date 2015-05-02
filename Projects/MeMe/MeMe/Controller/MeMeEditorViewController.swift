//
//  MeMeEditorViewController.swift
//  MeMe
//
//  Created by Sameer Khavanekar on 4/13/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

class MeMeEditorViewController: UIViewController, UIImagePickerControllerDelegate, MeMeFacebookViewControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var shareMemeButton: UIBarButtonItem!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    let topTextFieldDelegate = MeMeTextFieldDelegate()
    let bottomTextFieldDelegate = MeMeTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
        topTextField.defaultTextAttributes = MeMeTextFieldDelegate.memeTextAttributes
        bottomTextField.defaultTextAttributes = MeMeTextFieldDelegate.memeTextAttributes
        topTextField.placeholder = MeMeTextFieldDelegate.topDefaultText
        bottomTextField.placeholder = MeMeTextFieldDelegate.bottomDefaultText

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        if selectedImageView.image == nil{
            shareMemeButton.enabled = false
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectAnImageFromCamera(sender: UIBarButtonItem) {
        pickImageFromSource(UIImagePickerControllerSourceType.Camera)
    }
    @IBAction func selectAnImageFromAlbum(sender: UIBarButtonItem) {
        pickImageFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    @IBAction func selectAnImageFromFacebook(sender: UIBarButtonItem) {
        let navController = self.storyboard?.instantiateViewControllerWithIdentifier("facebookNavigationController") as! UINavigationController
        let facebookNavController: MeMeFacebookViewController = navController.viewControllers[0] as! MeMeFacebookViewController
        
        //let facebookNavController = self.storyboard?.instantiateViewControllerWithIdentifier("facebookViewController") as! MeMeFacebookViewController
        
        facebookNavController.delegate = self
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    func memeFacebookViewController(picker: MeMeFacebookViewController, didFinishPickingMediaWithInfo image: UIImage) {
        selectedImageView.image = image
        shareMemeButton.enabled = true
        showHideToolbarAndNavbar(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Image picking
    func pickImageFromSource(sourceType:UIImagePickerControllerSourceType){
        let memeImagePickerController = UIImagePickerController();
        memeImagePickerController.delegate = self
        memeImagePickerController.sourceType = sourceType
        self.presentViewController(memeImagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageView.image = image
            shareMemeButton.enabled = true
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onCancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getKeyboardHeight(notification:NSNotification) -> CGFloat{
        let userInfo = notification.userInfo;
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    func keyboardWillShow(notification:NSNotification){
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    func keyboardWillHide(notification:NSNotification){
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    func unsubscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Sharing and Saving Meme
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        //First generate memed image
        var memedImage = generateMemedImage()
        
        //Show activity controller to share memed image
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {activity, success, items, error in
            self.saveMeme(memedImage)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.presentViewController(activityVC, animated: true, completion: {() -> Void in
            //On finishing presenting view
        })
        //saveMeme(memedImage)
    }
    
    func saveMeme(memedImage:UIImage){
        var meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, originalImage: selectedImageView.image!, memedImage: memedImage)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage{
        showHideToolbarAndNavbar(true)
        
        //Render view to image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        showHideToolbarAndNavbar(false)
        return memedImage
    }
    
    func showHideToolbarAndNavbar(shouldHide:Bool){
        self.navigationController?.navigationBar.hidden = shouldHide
        toolbar.hidden = shouldHide
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
