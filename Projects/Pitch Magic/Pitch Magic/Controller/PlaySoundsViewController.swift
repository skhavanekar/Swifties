//
//  PlaySoundsViewController.swift
//  Pitch Magic
//
//  Created by Sameer Khavanekar on 1/27/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit


enum ButtonType: Int {
    case Slow = 0
    case Fast = 1
    case Chipmunk = 2
    case Vader = 3
    case Echo = 4
    case Reverb = 5
}

class PlaySoundsViewController: UIViewController {
    var receivedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initPitchEngine()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        PitchEngine.sharedInstance.stopAllAudio()
    }
    
    func initPitchEngine(){
        PitchEngine.sharedInstance.prepareToPlay(receivedAudio)
    }
    
    @IBAction func playSound(sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            PitchEngine.sharedInstance.playAudioAtRate(0.5)
            break
        case .Fast:
            PitchEngine.sharedInstance.playAudioAtRate(1.5)
            break
        case .Chipmunk:
            PitchEngine.sharedInstance.playSoundWithVariablePitch(1100)
            break
        case .Vader:
            PitchEngine.sharedInstance.playSoundWithVariablePitch(-1100)
            break
        case .Echo:
            PitchEngine.sharedInstance.playAudioAtRate(0.5)
            break
        case .Reverb:
            PitchEngine.sharedInstance.playAudioAtRate(0.5)
            break
            
        }
    }

    
    @IBAction func stopAudio(sender: UIButton) {
        PitchEngine.sharedInstance.stopAllAudio()
    }
}
