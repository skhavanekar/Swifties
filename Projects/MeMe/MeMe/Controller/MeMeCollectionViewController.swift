//
//  MeMeCollectionViewController.swift
//  MeMe
//
//  Created by Sameer Khavanekar on 4/16/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

let reuseIdentifier = "MeMeCell"

class MeMeCollectionViewController: UICollectionViewController {
    var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(MemeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if memes.count == 0{
            self.performSegueWithIdentifier("showMeMeEditorFromCollectionView", sender: nil)
            return;
        }
        
        self.collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        println("NUmber of row \(indexPath.row)")
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
    
        var meme = memes[indexPath.row]
        cell.memedImage.image = meme.memedImage
        
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath){
        let memeDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MeMeDetailViewController") as! MeMeDetailViewController
        memeDetailViewController.memeToDisplay = self.memes[indexPath.row]
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
        
    }
    
    
}
