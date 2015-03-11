//
//  RPS.swift
//  RoShambo
//
//  Created by Sameer Khavanekar on 3/10/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation

enum RPS{
    case Rock, Paper, Scissors
    
    init(){
        switch arc4random() % 3{
        case 0:
            self = .Rock
            break
        case 1:
            self = .Paper
        default:
            self = .Scissors
        }
        
    }
    
    
    func defeats(opponent: RPS) -> Bool{
        switch (self, opponent){
        case (.Paper, .Rock), (.Scissors, .Paper), (.Rock, .Scissors):
            return true
        default:
            return false
            
        }
    }
    
    func victoryData(opponent: RPS) -> (message:String, imageName:String){
        if self == opponent{
            return ("It's A Tie!", "itsATie")
        }
        switch self{
        case .Rock:
            return ("Rock crushes Scissors", "RockCrushesScissors")
        case .Paper:
            return ("Paper covers Rock", "PaperCoversRock")
        case .Scissors:
            return ("Scissors cut Paper", "ScissorsCutPaper")
        }
    }
    
}

extension RPS: Printable{
    var description: String{
        get{
            switch self{
            case .Rock:
                return "Rock"
            case .Paper:
                return "Paper"
            case .Scissors:
                return "Scissors"
            default:
                return "Not Found"
            }
        }
    }
}