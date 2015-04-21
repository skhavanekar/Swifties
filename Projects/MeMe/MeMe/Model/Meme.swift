//
//  Meme.swift
//  MeMe
//
//  Created by Sameer Khavanekar on 4/16/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText = "TOP"
    var bottomText = "BOTTOM"
    var originalImage:UIImage
    var memedImage:UIImage
    
    init(topText:String, bottomText:String, originalImage:UIImage, memedImage:UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
