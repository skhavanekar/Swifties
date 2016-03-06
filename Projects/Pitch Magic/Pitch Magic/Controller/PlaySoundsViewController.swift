//
//  PlaySoundsViewController.swift
//  Pitch Magic
//
//  Created by Sameer Khavanekar on 1/27/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func PlaySlowAudio(sender: UIButton) {
        PitchEngine.sharedInstance.playAudioAtRate(0.5)
        
    }
    @IBAction func PlayFastAudio(sender: UIButton) {
        PitchEngine.sharedInstance.playAudioAtRate(1.5)
    }
    
    @IBAction func PlayChipmunkAudio(sender: UIButton) {
       PitchEngine.sharedInstance.playSoundWithVariablePitch(1100)
    }
    
    @IBAction func PlayDarthVaderAudio(sender: UIButton) {
        PitchEngine.sharedInstance.playSoundWithVariablePitch(-1100)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        PitchEngine.sharedInstance.stopAllAudio()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
