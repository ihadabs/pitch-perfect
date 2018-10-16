//
//  PlaySoundVC.swift
//  pitchperfect
//
//  Created by Hadi Albinsaad on 16/10/2018.
//  Copyright © 2018 Hadi. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundVC: UIViewController {
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet var bigStack: UIStackView!
    @IBOutlet var topStack: UIStackView!
    @IBOutlet var midStack: UIStackView!
    @IBOutlet var botStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    /*
        Detecting orientation changes
     */
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let bigStackAixs: NSLayoutConstraint.Axis, smallStacksAixs: NSLayoutConstraint.Axis
        
        if UIDevice.current.orientation.isLandscape {
            bigStackAixs = .horizontal
            smallStacksAixs = .vertical
        } else {
            bigStackAixs = .vertical
            smallStacksAixs = .horizontal
        }
       
        bigStack.axis = bigStackAixs
        topStack.axis = smallStacksAixs
        midStack.axis = smallStacksAixs
        botStack.axis = smallStacksAixs
    }
    
}
