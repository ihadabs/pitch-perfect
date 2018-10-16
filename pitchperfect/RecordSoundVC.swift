//
//  RecordSoundVC.swift
//  pitchperfect
//
//  Created by Hadi Albinsaad on 16/10/2018.
//  Copyright © 2018 Hadi. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundVC: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordAudioButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(recording: false)
    }
    
    func configureUI(recording: Bool) {
        recordingLabel.text = recording ? "Recording in progress" : "Tap to Recoed"
        stopRecordingButton.isEnabled = recording
        recordAudioButton.isEnabled = !recording
    }
    
    @IBAction func recordAudio(_ sender: UIButton) {
        configureUI(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(.playAndRecord, mode: .default)
        try! session.setActive(true)
        try! session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }

    @IBAction func stopRecording(_ sender: UIButton) {
        configureUI(recording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("The recording failed!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC = segue.destination as! PlaySoundVC
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

