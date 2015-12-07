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

class AudioEditorViewController: UIViewController, AVAudioPlayerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var player: AVAudioPlayer!
    
    var url:NSURL!
    
    /*@IBOutlet var Play: UIButton!
    
    @IBOutlet var Stop: UIButton!
    
    @IBOutlet var Edit: UIButton!
    
    @IBOutlet var Delete: UIButton!*/
    
    //Let the user to go back to the library
    @IBOutlet var LibraryBtn: UIButton!
    
    //Let the user to edit the music and allow a pop-up window to choose between overlaying and appending
    @IBAction func EditBtn(sender: UIButton) {
        
    }
    
    //Play the recorded file
    @IBAction func PlayBtn_one(sender: UIButton) {
    }
    
    //Play the track from friend
    @IBAction func PlayBtn_two(sender: UIButton) {
    }
    
    //Allow the user to discard the current file and pick another one from the library
    @IBAction func DiscardBtn(sender: UIButton) {
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        return cell as UITableViewCell
    }
    

    
    /*@IBAction func test(sender: AnyObject) {
        do {
            self.player = try AVAudioPlayer(contentsOfURL: url!)
            player.delegate = self
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        }
    }
    
    
    func playSound() -> SystemSoundID {
        let soundID: SystemSoundID = 0
        let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "", "", nil)
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        CFRelease(?)
        return soundID
    }*/
    
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
