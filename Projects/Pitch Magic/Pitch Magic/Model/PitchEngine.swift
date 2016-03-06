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
    var audioPlayer:AVAudioPlayer!
    var audioEngine:AVAudioEngine
    var audioFile:AVAudioFile
    var error:NSError?
    
    init(receivedAudio:RecordedAudio!){
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathURL)
        
        audioEngine = AVAudioEngine()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
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
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let audioPitch = AVAudioUnitTimePitch()
        audioPitch.pitch = pitchLevel
        audioEngine.attachNode(audioPitch)
        
        audioEngine.connect(audioPlayerNode, to: audioPitch, format: nil)
        audioEngine.connect(audioPitch, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: onAudioCompletion)
                
        do {
            try audioEngine.start()
        } catch _ {
        }
        
        audioPlayerNode.play()
    }
    
    func onAudioCompletion(){
        dispatch_async(dispatch_get_main_queue()){
            print("Audio 1 playback just completed!")
        }
        print("Audio playback just completed!")
    }
    
    func stopAllAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
}