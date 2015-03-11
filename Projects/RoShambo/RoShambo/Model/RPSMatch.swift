//
//  RPSMatch.swift
//  RoShambo
//
//  Created by Sameer Khavanekar on 3/10/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation

struct RPSMatch {
    let player: RPS
    let computer: RPS
    
    init(player: RPS, computer: RPS){
        self.player = player
        self.computer = computer
    }
    
    var winner: RPS{
        get{
            return player.defeats(computer) ? player : computer
        }
    }
    
    var result: (message: String, image:String){
        get{
            var victoryMessage = ""
            var (result, imageName) = ("", "")
            if player == computer{
                (result, imageName) = player.victoryData(computer)
            }else if player.defeats(computer){
                victoryMessage = "You win!"
                (result, imageName) = player.victoryData(computer)
            }else{
                victoryMessage = "You lose!"
                (result, imageName) = computer.victoryData(player)
            }
            
            return (victoryMessage+" "+result, imageName)
            
        }
    }
}
