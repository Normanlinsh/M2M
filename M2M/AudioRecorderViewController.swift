//
//  AudioRecorderViewController.swift
//  M2M
//
//  Created by Sheng-Hua.Lin on 11/11/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecorderViewController: UIViewController {
    
    var recorder: AVAudioRecorder!
    var player:AVAudioPlayer!
    var meterTimer:NSTimer!
    var soundFileURL:NSURL!
    
    @IBOutlet var Record: UIButton!
    @IBOutlet var Stop: UIButton!
    @IBOutlet var Play: UIButton!
    @IBOutlet var Status: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Stop.enabled = false
        Play.enabled = false
        /*setSessionPlayback()
        askForNotifications()
        checkHeadphones()*/ //methods used in example
        
        func updateAudioMeter(timer:NSTimer) {
            
            if recorder.recording {
                let min = Int(recorder.currentTime / 60)
                let sec = Int(recorder.currentTime % 60)
                let s = String(format: "%02d:%02d", min, sec)
                Status.text = s
                recorder.updateMeters()
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        recorder = nil
        player = nil
    }
    
    @IBAction func record(sender: UIButton) {
        
    }
    @IBAction func play(sender: UIButton){
        
    }
    @IBAction func stop(sender: UIButton) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
