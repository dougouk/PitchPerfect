//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Dan on 2/22/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var recordedAudioURL : URL!
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer : Timer!
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    enum ButtonType: Int {case slow=1, fast, darthVader, chipmunk, echo, reverb}
    
    @IBAction func playSoundForButton(_ sender:UIButton){
        print("playSoundForButton")
        switch(ButtonType(rawValue: sender.tag)!){
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .darthVader:
            playSound(pitch: -1000)
        case .chipmunk:
            playSound(pitch: 1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopPlaying(_ sender:AnyObject){
        print("stopPlaying")
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
