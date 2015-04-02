//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Charlie Rehor on 3/15/15.
//  Copyright (c) 2015 Charlie Rehor. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData


class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var squirrelPlayButton: UIButton!
    
    @IBOutlet weak var darthVaderButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }
    
    
    @IBAction func playLikeChipmonk(sender: UIButton) {
        
        playAtVariablePitch(1000)
    }
    
    @IBAction func playLikeDarth(sender: UIButton) {
        
        playAtVariablePitch(-1000)
    }
    
    
    func playAtVariablePitch(pitch: Float) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        
        var playerNode = AVAudioPlayerNode()
        
        audioEngine.attachNode(playerNode)
        
        var pitchNode = AVAudioUnitTimePitch()
        
        pitchNode.pitch = pitch
        
        audioEngine.attachNode(pitchNode)
        
        audioEngine.connect(playerNode, to: pitchNode, format: nil)
        
        audioEngine.connect(pitchNode, to: audioEngine.outputNode, format: nil)
        
        playerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)

        audioEngine.startAndReturnError(nil)
        
        playerNode.play()
    }
    
    
    @IBAction func stopPlay(sender: UIButton) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    
    @IBAction func playFast(sender: UIButton) {
        
        playAudioAtSpeed(1.5)
    }
    
    func playAudioAtSpeed(speed: Float) -> Bool {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0

        audioPlayer.rate = speed
        audioPlayer.play()

        return true
    }
    
    

    @IBAction func playSlow(sender: UIButton) {
        
        playAudioAtSpeed(0.5)
    }
}
