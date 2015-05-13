//
//  Search.swift
//  Data Structures
//
//  Created by Sameer Khavanekar on 5/7/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation

class Search {
    static func BinarySearch(searchArray:[Int], searchKey:Int, low:Int, high:Int) -> Int?{
        if low > high{
            return nil
        }
        var mid = ((low + high) / 2) as Int
        
        if searchKey == searchArray[mid]{
            return searchKey
        }else if searchKey < searchArray[mid] {
            return BinarySearch(searchArray, searchKey: searchKey, low: low, high: mid-1)
        }else{
            return BinarySearch(searchArray, searchKey: searchKey, low: mid+1, high: high)
        }
        
    }
}