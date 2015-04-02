//
//  RecordSoundsViewController
//  Pitch Perfect
//
//  Created by Charlie Rehor on 3/5/15.
//  Copyright (c) 2015 Charlie Rehor. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    var recordedAudio: RecordedAudio!
    
    var audioRecorder:AVAudioRecorder!

    
    // Override to set UI
    override func viewWillAppear(animated: Bool) {

        stopRecordingButton.hidden = true
        recordingLabel.text = "tap to record"
    }


    @IBAction func recordAudio(sender: UIButton) {
        
        recordingLabel.text = "recording - tap again to pause"
        stopRecordingButton.hidden = false
        
        if (audioRecorder != nil && audioRecorder.recording) {
            
            audioRecorder.pause()
            recordingLabel.text = "paused - tap to resume"

        }
            
        else if (audioRecorder != nil) {
            
            audioRecorder.record()
        }

        else {
            
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            
            let currentDateTime = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "ddMMyyyy-HHmmss"
            let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
            let pathArray = [dirPath, recordingName]
            var filePath = NSURL.fileURLWithPathComponents(pathArray)
            println(filePath)
        
            var session = AVAudioSession.sharedInstance()
            session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
            audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        }
        
    }

    @IBAction func stopRecording(sender: UIButton) {
        
        recordingLabel.text = "tap to record"
        stopRecordingButton.hidden = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if (segue.identifier == "stopRecording") {
            
            let playSoundsViewController: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            
            let data = sender as RecordedAudio
            
            playSoundsViewController.receivedAudio = data
        
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if flag {
            
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)
            
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
           
        }
        
        else {
            
            println("Did not successfully finish recording.")
            
            recordButton.enabled = true
            stopRecordingButton.hidden = true
        }
    }
}

