//
//  RecordSoundsViewController.swift
//  Pitch Magic
//
//  Created by Sameer Khavanekar on 1/27/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var notificationRecordLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    
    var audioRecorder:AVAudioRecorder!
    
    let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),
        AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
        AVNumberOfChannelsKey : NSNumber(int: 1),
        AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]
    
    
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
        print("In RecordAudio")
        startRecordingButton.enabled = false
        stopRecordingButton.hidden = false
        notificationRecordLabel.text = recordingInProgressString
        StartRecording()
    }
    
    func StartRecording(){
        //Generating path for storing recorded audio file
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        //Generating name for audio file to store
        //In order to generate unique name, using current date-time and attaching extension
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYYmmdd-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        
        if let filePath = NSURL.fileURLWithPathComponents([dirPath, recordingName]) {
            print(filePath)
            
            //set up audio session
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                
                //Init and prepate audio recorder
                try audioRecorder = AVAudioRecorder(URL: filePath, settings: recordSettings)
                
                audioRecorder.delegate = self
                audioRecorder.meteringEnabled = true
                audioRecorder.prepareToRecord()
                audioRecorder.record()
                
            } catch _ {
                print("There was error recording..")
            }
            
            
        }
    }
    
    @IBAction func StopAudioRecording(sender: UIButton) {
        startRecordingButton.enabled = true
        stopRecordingButton.hidden = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch _ {
        }
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            print("Recording has finished successfully!")
            let recordedAudio = RecordedAudio(filePathURL: recorder.url , title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecordingSegue", sender: recordedAudio)
        }else{
            print("Audio recording failed to complete!")
            startRecordingButton.enabled = true
            stopRecordingButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecordingSegue"){
            let playSoundVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundVC.receivedAudio = data
        }
    }
}

