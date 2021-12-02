//
//  Recorder.swift
//  ProductiveFamilies
//
//  Created by FAB LAB on 15/12/2020.
//  Copyright © 2020 ADEL ELGAZAR. All rights reserved.
//

import Foundation
import AVFoundation

class Recorder: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    var audioRecorder: AVAudioRecorder!
//    var audioPlayer : AVAudioPlayer!
    var meterTimer:Timer!
    var isAudioRecordingGranted = false
    var isRecording = false
    var isPlaying = false
    var currentVC:UIViewController?
    init(vc:UIViewController) {
        super.init()
        self.currentVC = vc
        check_record_permission()
    }
    
    public func startRecording() {
        if isRecording {
            finishAudioRecording(success: true)
            isRecording = false
        } else {
            setup_recorder()
            
            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            isRecording = true
        }
    }
    
    public func play(_ sender: Any) {
        if isPlaying {
//            audioPlayer.stop()
            isPlaying = false
        } else {
            if FileManager.default.fileExists(atPath: getFileUrl().path) {
                prepare_play()
//                audioPlayer.play()
                isPlaying = true
            } else {
                K_AppDelegate.openFailPopup(vc: currentVC!, msg: "Audio file is missing.")
            }
        }
    }
    
    private func check_record_permission() {
        switch AVAudioSession.sharedInstance().recordPermission() {
        
        case AVAudioSessionRecordPermission.granted:
            isAudioRecordingGranted = true
            
        case AVAudioSessionRecordPermission.denied:
            isAudioRecordingGranted = false
            
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                if allowed {
                    self.isAudioRecordingGranted = true
                } else {
                    self.isAudioRecordingGranted = false
                }
            })
            
        default:
            break
        }
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func getFileUrl() -> URL {
        let filename = "record.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }

    private func setup_recorder() {
        if isAudioRecordingGranted {
            let session = AVAudioSession.sharedInstance()
            do {
                try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            K_AppDelegate.openFailPopup(vc: currentVC!, msg: "Don't have access to use your microphone.")
        }
    }
    
    @objc func updateAudioMeter(timer: Timer) {
        if audioRecorder.isRecording {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
//            recordingTimeLabel.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }

    func finishAudioRecording(success: Bool) {
        if success {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            print("recorded successfully.")
        } else {
            K_AppDelegate.openFailPopup(vc: currentVC!, msg: "Recording failed.")
        }
    }

    func prepare_play() {
        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
//            audioPlayer.delegate = self
//            audioPlayer.prepareToPlay()
        } catch {
            print("Error")
        }
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishAudioRecording(success: false)
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    }
}
