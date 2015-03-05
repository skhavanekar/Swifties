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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Show/Hide for initial set up
        stopRecordingButton.hidden = true
        notificationRecordLabel.text = "Tap to Record"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func RecordAudio(sender: UIButton) {
        //Start recording
        //TODO: Show notification "Recording in Progress!"
        //TODO: Record voice.
        println("In RecordAudio")
        startRecordingButton.enabled = false
        stopRecordingButton.hidden = false
        notificationRecordLabel.text = "Recording in Progress. \nTap stop to end Recording!"
        StartRecording()
    }
    
    func StartRecording(){
        //Generating path for storing recorded audio file
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        //Generating name for audio file to store
        //In order to generate unique name, using current date-time and attaching extension
        var currentDateTime = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "YYYYmmdd-HHmmss"
        var recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        
        let filePath = NSURL.fileURLWithPathComponents([dirPath, recordingName])
        println(filePath)
        
        //set up audio session
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        //Init and prepate audio recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings:nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func StopAudioRecording(sender: UIButton) {
        startRecordingButton.enabled = true
        stopRecordingButton.hidden = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            println("Recording has finished successfully!")
            var recordedAudio = RecordedAudio(filePathURL: recorder.url , title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecordingSegue", sender: recordedAudio)
        }else{
            println("Audio recording failed to complete!")
            startRecordingButton.enabled = true
            stopRecordingButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecordingSegue"){
            let playSoundVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundVC.receivedAudio = data
        }
    }
}

