//
//  FBManager.swift
//  MeMe
//
//  Created by Sameer Khavanekar on 4/22/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation

class FBManager {
    var albums:[FBAlbum] = []
    
    func allAlbums(){
        if ((FBSDKAccessToken.currentAccessToken()) != nil) {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/albums", parameters: nil)
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                if ((error) != nil)
                {
                    // Process error
                    println("Error: \(error)")
                }
                else
                {
                    let graphData = (result["data"] as! NSArray) as Array
                    //println("Graph Data \(graphData)")
                    for data in graphData{
                        if let link:String = data["link"] as? String{
                            println("\(link)")
                            let id = data["id"] as! String;
                            var cover = ""
                            if let existsCoverPhoto : AnyObject = data["cover_photo"]{
                                let coverLink = existsCoverPhoto as! String;
                                cover = "/\(id)/picture";
                                
                                //Need to download album cover here...
                                let parameters = ["type":"small"]
                                let graphRequest = FBSDKGraphRequest(graphPath: cover, parameters: parameters, HTTPMethod: "GET")
                                let graphRequestConnection = FBSDKGraphRequestConnection()
                                graphRequestConnection.addRequest(graphRequest, completionHandler: {(connection, result, error) -> Void in
                                    println(graphRequestConnection.URLResponse)
                                    //let urlString = connection.URLResponse.URL
                                    //let coverPhotoURL = NSURL(string: )
                                    
                                    if let imageData = NSData(contentsOfURL: connection.URLResponse.URL!){
                                        let albumImage = UIImage(data: imageData)
                                        let album = FBAlbum(name: data["id"]! as! String, link: link, cover: cover)
                                        album.albumPicture = albumImage
                                        self.albums.append(album)
                                    }
                                })
                                graphRequestConnection.start()
                                
                                
                            }
                            
                        }
                    }
                    
                }
            })
            
            
        }
    }
    
    //TOTO : Setup UI Collection
    // Show all the albums
    // Retrieve and show the photos
    
    func retrieveAlbumPhoto(forLink:String){
        let parameters = ["type":"small"]
        let graphRequest = FBSDKGraphRequest(graphPath: forLink, parameters: parameters, HTTPMethod: "GET")
        let graphRequestConnection = FBSDKGraphRequestConnection()
        graphRequestConnection.addRequest(graphRequest, completionHandler: {(connection, result, error) -> Void in
            println(graphRequestConnection.URLResponse)
        })
        graphRequestConnection.start()
        
        return;
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                let graphData = (result["data"] as! NSArray) as Array
//                
//                let pictureURL = obj.valueForKey("picture") as String;
//                let url = NSURL(string: pictureURL);
//                let picData = NSData(contentsOfURL: url);
//                
//                var picture:UIImage =
//                
//                var pictures:UIImage[] = UIImage[]();
//                let graphData = result.valueForKey("data") as Array;
//                var albums:AlbumModel[] =  AlbumModel[]();
//                for obj:FBGraphObject in graphData{
//                    println(obj.description);
//                    let pictureURL = obj.valueForKey("picture") as String;
//                    let url = NSURL(string: pictureURL);
//                    let picData = NSData(contentsOfURL: url);
//                    let img = UIImage(data: picData);
//                    pictures.append(img)
            }
        })
        
    }
}