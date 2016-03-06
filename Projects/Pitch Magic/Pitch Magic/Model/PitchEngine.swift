//
//  PitchEngine.swift
//  Pitch Magic
//
//  Created by Sameer Khavanekar on 3/4/15.
//  Copyright (c) 2015 Sameer Khavanekar. All rights reserved.
//

import Foundation
import AVFoundation


protocol PitchEngineRecordingDelegate {
    func didStartRecording()
    func didFinishRecording(recordedAudio: RecordedAudio!)
    func didFailRecording(error:NSError!)
}

protocol PitchEnginePlayerDelegate {
    func didFailToPlay(error:NSError!)
}


class PitchEngine: NSObject, AVAudioRecorderDelegate {
    var audioPlayer:AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var error:NSError?
    
    var audioRecorder: AVAudioRecorder!
    
    var recordingDelegate: PitchEngineRecordingDelegate?
    var playerDelegate: PitchEnginePlayerDelegate?
    
    static let sharedInstance = PitchEngine()
    
    let recordingSettings = [
        AVFormatIDKey: Int(kAudioFormatLinearPCM), // kAudioFormatMPEG4AAC - To generate failed recording case use this
        AVSampleRateKey: 44100.0,
        AVNumberOfChannelsKey:1,
        AVLinearPCMBitDepthKey:8,
        AVLinearPCMIsFloatKey:false,
        AVLinearPCMIsBigEndianKey:false,
        AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
    ]
    
    // MARK: Recording
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
                recordingDelegate?.didStartRecording()
                
            } catch let error as NSError {
                recordingDelegate?.didFailRecording(error)
            } catch {
                recordingDelegate?.didFailRecording(nil)
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
    
    // MARK: Playback
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
    
    func playSound(rate rate: Float? = nil, pitch: Float? = nil, echo: Bool = false, reverb: Bool = false ) {
        stopAllAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        
        // Node for adjusting rate/pitch
        let changeRatePitchNode = AVAudioUnitTimePitch()
        if let pitch = pitch {
            changeRatePitchNode.pitch = pitch
        }
        if let rate = rate {
            changeRatePitchNode.rate = rate
        }
        audioEngine.attachNode(changeRatePitchNode)
        
        
        // Node for adding echo
        let echoNode = AVAudioUnitDistortion()
        echoNode.loadFactoryPreset(AVAudioUnitDistortionPreset.MultiEcho1)
        audioEngine.attachNode(echoNode)
        
        // Node for adding reverb
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        reverbNode.wetDryMix = 50
        audioEngine.attachNode(reverbNode)
        
        
        //audioEngine.connect(audioPlayerNode, to: audioPitch, format: nil)
        //audioEngine.connect(audioPitch, to: audioEngine.outputNode, format: nil)
        
        if echo == true && reverb == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, echoNode, reverbNode, audioEngine.outputNode)
        } else if echo == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, echoNode, audioEngine.outputNode)
        } else if reverb == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, reverbNode, audioEngine.outputNode)
        } else {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, audioEngine.outputNode)
        }
        
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: onAudioCompletion)
        
        do {
            try audioEngine.start()
        } catch _ {
        }
        
        audioPlayerNode.play()
    }
    
    func connectAudioNodes(nodes: AVAudioNode...) {
        for x in 0..<nodes.count - 1 {
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFile.processingFormat)
        }
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
    
    // MARK: AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            let recordedAudio = RecordedAudio(filePathURL: recorder.url , title: recorder.url.lastPathComponent!)
            recordingDelegate?.didFinishRecording(recordedAudio)
        }else{
            recordingDelegate?.didFinishRecording(nil)
        }
    }
}