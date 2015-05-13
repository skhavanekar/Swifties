//
//  SLNode.swift
//  Data Structures
//
//  Created by Sameer Khavanekar on 5/7/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation

class SLNode <T> : Node<T>{
    var next: SLNode?
    
    override init(value: T) {
        super.init(value: value)
    }
}