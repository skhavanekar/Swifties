//
//  Enums.swift
//  RoShambo
//
//  Created by Sameer Khavanekar on 3/6/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation

enum Roshambo:Int{
    case Rock
    case Paper
    case Scissors
    
    
    static func winner(playerChoice:Roshambo, computerChoice:Roshambo) -> (message:String, imageName:String){
        if playerChoice == computerChoice{
            return ("It's a draw", "itsATie")
        }
        switch playerChoice{
        case .Rock:
            if computerChoice == .Paper{
                return ("Paper covers Rock. You Loose", "PaperCoversRock")
            }
            if computerChoice == .Scissors{
                return ("Rock crushes Scissors. You Win", "RockCrushesScissors")
            }
            break
        case .Paper:
            if computerChoice == .Rock{
                return ("Paper covers Rock. You Win", "PaperCoversRock")
            }
            if computerChoice == .Scissors{
                return ("Scissor cut Paper. You Loose", "ScissorsCutPaper")
            }
            break
        case .Scissors:
            if computerChoice == .Paper{
                return ("Scissor cut Paper. You Win", "ScissorsCutPaper")
            }
            if computerChoice == .Rock{
                return ("Rock crushes Scissors. You Loose", "RockCrushesScissors")
            }
        default:
            return ("Something went horribly wrong!", "itsATie")
        }
        
        return ("Something went horribly wrong!", "itsATie")
    }
    
    static func random() -> Roshambo{
        let maxValue = 3.0
        let rand = Int(arc4random_uniform(UInt32(maxValue)))
        return Roshambo(rawValue: rand)!
    }
}
