//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Dan on 2/20/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate{

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var startRecording: UIButton!
    @IBOutlet weak var stopRecording: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecording.isEnabled = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: Any) {
        print("recordAudio")
        recordingLabel.text = "Recording In Progress"
        stopRecording.isEnabled = true;
        startRecording.isEnabled = false;
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator:"/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord,
                                 with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self;
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(_ sender: Any) {
        print("stopRecording")
        recordingLabel.text = "Recording Stopped"
        stopRecording.isEnabled = false;
        startRecording.isEnabled = true;
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool){
        print("Finished Recording")
        if(flag){
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            print("Recording was not successful")
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "stopRecording"{
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL;
        }
    }
    
    
}

