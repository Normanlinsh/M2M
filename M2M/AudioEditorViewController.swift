//
//  AudioEditorViewController.swift
//  M2M
//
//  Created by Mark Chae on 11/11/15.
//  Copyright (c) 2015 Lin. All rights reserved.
//

import AudioToolbox
import AVFoundation //Experimenting
import UIKit
import Parse

var audioPlayer = AVAudioPlayer()

class AudioEditorViewController: UIViewController, AVAudioPlayerDelegate {
    
    func playSound() -> SystemSoundID {
        var soundID: SystemSoundID = 0
        /*let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "", "", nil)
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        CFRelease(?)*/
        return soundID
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Experimenting
        /*
        var Sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("", ofType: "wav"))
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: Sound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        */
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "editorToLibrarySegue"){
            
            let svc = segue.destinationViewController as! MusicLibraryViewController;
            svc.fromEditor = true
        }
    }
}
