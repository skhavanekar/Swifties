//
//  Queue.swift
//  Data Structures
//
//  Created by Sameer Khavanekar on 5/7/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation

struct Queue <T>{
    private var top: SLNode<T>!
    private var bottom: SLNode<T>!
    
    init(){
        top =  nil
        bottom = nil
    }
    
    mutating func enqueue(item: T){
        var newNode = SLNode(value: item)
        
        if top == nil{
            top = newNode
            bottom = top
            return
        }
        
        bottom.next = newNode
        bottom = newNode
    }
    
    mutating func dequeue() -> T?{
        var topItem = top?.value
        if topItem == nil{
            return nil
        }
        if let nextItem = top.next{
            top = nextItem
        }else{
            top = nil
            bottom = nil
        }
        return topItem
    }
    
}

extension Queue{
    func peek() -> T?{
        return top?.value
    }
    func isEmpty() -> Bool{
        return top == nil ? true : false
    }
}