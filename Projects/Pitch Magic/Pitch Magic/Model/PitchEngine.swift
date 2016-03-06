//
//  PitchEngine.swift
//  Pitch Magic
//
//  Created by Sameer Khavanekar on 3/4/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation
import AVFoundation


protocol PitchEngineDelegate {
    func didStartRecording()
    func didFinishRecording(recordedAudio: RecordedAudio!)
}


class PitchEngine: NSObject, AVAudioRecorderDelegate {
    var audioPlayer:AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var error:NSError?
    
    var audioRecorder: AVAudioRecorder!
    
    var delegate: PitchEngineDelegate?
    
    static let sharedInstance = PitchEngine()
    
    let recordingSettings = [
        AVFormatIDKey: Int(kAudioFormatLinearPCM),
        AVSampleRateKey: 44100.0,
        AVNumberOfChannelsKey:1,
        AVLinearPCMBitDepthKey:8,
        AVLinearPCMIsFloatKey:false,
        AVLinearPCMIsBigEndianKey:false,
        AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
    ]
    
    func startRecording() {
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
                audioRecorder = try AVAudioRecorder(URL: filePath, settings: recordingSettings as! [String : AnyObject])
                
                audioRecorder.delegate = self
                audioRecorder.meteringEnabled = true
                audioRecorder.prepareToRecord()
                audioRecorder.record()
                
            } catch let error as NSError {
                print("Error \(error.description)")
            } catch {
                print("Some other error")
            }
        }
    }
    
    func stopRecording() {
        if audioRecorder != nil {
            audioRecorder.stop()
        }
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch _ {
        }
    }
    
    
    func playAudioAtRate(playBackRate:Float){
        stopAllAudio()
        audioPlayer.currentTime = 0
        audioPlayer.rate = playBackRate
        audioPlayer.play()
    }
    
    
    func prepareToPlay(receivedAudio:RecordedAudio!){
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
        } catch _ {
            print("Error")
        }
        audioPlayer.enableRate = true
        audioPlayer.prepareToPlay()
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
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            let recordedAudio = RecordedAudio(filePathURL: recorder.url , title: recorder.url.lastPathComponent!)
            delegate?.didFinishRecording(recordedAudio)
            
            //self.performSegueWithIdentifier("stopRecordingSegue", sender: recordedAudio)
        }else{
            print("Audio recording failed to complete!")
            delegate?.didFinishRecording(nil)
            //startRecordingButton.enabled = true
            //stopRecordingButton.hidden = true
        }
    }
}