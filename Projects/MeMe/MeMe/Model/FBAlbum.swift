//
//  FBAlbum.swift
//  MeMe
//
//  Created by Sameer Khavanekar on 4/22/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation

class FBAlbum {
    var name:String
    var link:String
    var cover:String
    var albumPicture:UIImage?
    
    init(name:String, link:String, cover:String){
        self.name = name
        self.link = link
        self.cover = cover
    }
}
