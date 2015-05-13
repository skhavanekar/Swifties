//
//  Stack.swift
//  Data Structures
//
//  Created by Sameer Khavanekar on 5/7/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation

struct Stack <T>{
    var items = [T]()
    
    mutating func push(item:T){
        items.append(item)
    }
    mutating func pop() -> T{
        return items.removeLast()
    }
}


extension Stack{
    var topItem: T? {
        return items.last
    }
}