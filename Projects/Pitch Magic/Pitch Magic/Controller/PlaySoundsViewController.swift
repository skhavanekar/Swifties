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

class PlaySoundsViewController: UIViewController, PitchEnginePlayerDelegate {
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
        PitchEngine.sharedInstance.playerDelegate = self
        PitchEngine.sharedInstance.prepareToPlay(receivedAudio)
    }
    
    @IBAction func playSound(sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            PitchEngine.sharedInstance.playSound(rate: 0.5)
            break
        case .Fast:
            PitchEngine.sharedInstance.playSound(rate: 1.5)
            break
        case .Chipmunk:
            PitchEngine.sharedInstance.playSound(pitch: 1100)
            break
        case .Vader:
            PitchEngine.sharedInstance.playSound(pitch: -1100)
            break
        case .Echo:
            PitchEngine.sharedInstance.playSound(echo: true)
            break
        case .Reverb:
            PitchEngine.sharedInstance.playSound(reverb: true)
            break
            
        }
    }

    
    @IBAction func stopAudio(sender: UIButton) {
        PitchEngine.sharedInstance.stopAllAudio()
    }
    
    func didFailToPlay(error: NSError!) {
        showAlert(error.description)
    }
}
