//
//  PitchEngine.swift
//  Pitch Magic
//
//  Created by Sameer Khavanekar on 3/4/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation
import AVFoundation

class PitchEngine{
    var audioPlayer:AVAudioPlayer
    var audioEngine:AVAudioEngine
    var audioFile:AVAudioFile
    var error:NSError?
    
    init(receivedAudio:RecordedAudio!){
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
        
        audioEngine = AVAudioEngine()
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: &error)
        audioPlayer.enableRate = true
        audioPlayer.prepareToPlay()
    }
    
    func playAudioAtRate(playBackRate:Float){
        stopAllAudio()
        audioPlayer.currentTime = 0
        audioPlayer.rate = playBackRate
        audioPlayer.play()
    }
    
    func playSoundWithVariablePitch(pitchLevel:Float){
        stopAllAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var audioPitch = AVAudioUnitTimePitch()
        audioPitch.pitch = pitchLevel
        audioEngine.attachNode(audioPitch)
        
        audioEngine.connect(audioPlayerNode, to: audioPitch, format: nil)
        audioEngine.connect(audioPitch, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
                
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func stopAllAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
}