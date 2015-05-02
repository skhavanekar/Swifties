//
//  MeMeFacebookViewController.swift
//  MeMe
//
//  Created by Sameer Khavanekar on 4/21/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

let fbReuseIdentifier = "fbImageCell"

class MeMeFacebookViewController: UIViewController, FBSDKLoginButtonDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate{
    var delegate: protocol<MeMeFacebookViewControllerDelegate>?
    
    @IBOutlet weak var fbCollectionView: UICollectionView!
    var fbLoginView:FBSDKLoginButton!
    var fbProfileManager:FBManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            println("User already logged in.")
            //fbLoginView.hidden = false
            fbProfileManager = FBManager();
            fbProfileManager.allAlbums()
            //returnUserData()
        }
        else
        {
            println("Adding Facebook button!")
            fbLoginView  = FBSDKLoginButton()
            self.view.addSubview(fbLoginView)
            fbLoginView.center = self.view.center
            fbLoginView.readPermissions = ["public_profile", "email", "user_photos", "user_friends"]
            fbLoginView.delegate = self
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let delayInSeconds = 5.0
        let popTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(delayInSeconds * Double(NSEC_PER_SEC))) // 1
        dispatch_after(popTime, dispatch_get_main_queue(), {
            self.fbCollectionView.reloadData()
            
        })
    }
    @IBAction func onCancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Facebook login button delegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        //loginButton.hidden = true
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            self.fbCollectionView.reloadData()
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
            }
        })
    }
    
    
    // MARK : Collection View Data Source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return fbProfileManager.albums.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        println("NUmber of row \(indexPath.row)")
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(fbReuseIdentifier, forIndexPath: indexPath) as! FBCollectionViewCell
        // Configure the cell
        let albumData:FBAlbum = fbProfileManager.albums[indexPath.row]
        
        if(albumData.cover != ""){
            cell.fbImageView.image = albumData.albumPicture
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (self.delegate != nil){
            let albumData:FBAlbum = self.fbProfileManager.albums[indexPath.row]
            self.delegate?.memeFacebookViewController(self, didFinishPickingMediaWithInfo: albumData.albumPicture!)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationVC: AnyObject = segue.destinationViewController
        
    }*/

}



protocol MeMeFacebookViewControllerDelegate : NSObjectProtocol {
    
    // The picker does not dismiss itself; the client dismisses it in these callbacks.
    // The delegate will receive one or the other, but not both, depending whether the user
    // confirms or cancels.
    
    func memeFacebookViewController(picker: MeMeFacebookViewController, didFinishPickingMediaWithInfo image: UIImage)
}