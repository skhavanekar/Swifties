//
//  RecordSoundsViewController.swift
//  Pitch Magic
//
//  Created by Sameer Khavanekar on 1/27/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit
import AVFoundation

let playRecordedAudioSegueIdentifier = "stopRecordingSegue"

class RecordSoundsViewController: UIViewController, PitchEngineDelegate {

    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var notificationRecordLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PitchEngine.sharedInstance.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Show/Hide for initial set up
        stopRecordingButton.hidden = true
        notificationRecordLabel.text = tapToRecordString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func RecordAudio(sender: UIButton) {
        //Start recording
        startRecordingButton.enabled = false
        stopRecordingButton.hidden = false
        notificationRecordLabel.text = prepareForRecordingString
        
        PitchEngine.sharedInstance.startRecording()
    }
    
    func StartRecording(){
        //Generating path for storing recorded audio file
        
    }
    
    @IBAction func StopAudioRecording(sender: UIButton) {
        startRecordingButton.enabled = true
        stopRecordingButton.hidden = true
        PitchEngine.sharedInstance.stopRecording()
    }
    
    func didStartRecording() {
        notificationRecordLabel.text = recordingInProgressString
    }
    
    func didFailRecording(error: NSError!) {
        if error != nil {
            notificationRecordLabel.text = error.description
        }
        startRecordingButton.enabled = true
        stopRecordingButton.hidden = true
    }
    
    func didFinishRecording(recordedAudio: RecordedAudio!) {
        if recordedAudio != nil {
            self.performSegueWithIdentifier(playRecordedAudioSegueIdentifier, sender: recordedAudio)
        } else {
            startRecordingButton.enabled = true
            stopRecordingButton.hidden = true
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == playRecordedAudioSegueIdentifier){
            let playSoundVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundVC.receivedAudio = data
        }
    }
}

