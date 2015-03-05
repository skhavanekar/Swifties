//
//  RecordedAudio.swift
//  Pitch Magic
//
//  Created by Sameer Khavanekar on 1/27/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation

class RecordedAudio:NSObject{
    var filePathURL:NSURL
    var title:String
    
    init(filePathURL:NSURL, title:String) {
        self.filePathURL = filePathURL
        self.title = title
    }
}
