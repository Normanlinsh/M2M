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
    
    var player : AVAudioPlayer!
    var secondAudioFileData : NSData!
    var fromLibrary = false
    var fromLibraryFileName = ""
    
    var url:NSURL!
    
    /*@IBOutlet var Play: UIButton!
    
    @IBOutlet var Stop: UIButton!
    
    @IBOutlet var Edit: UIButton!
    
    @IBOutlet var Delete: UIButton!*/
    

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
    
    override func viewWillAppear(animated: Bool) {
        if fromLibrary {
            retrieveFromParse(fromLibraryFileName)
        }
    }
    
    // retrieve the audio file from parse by the audio name passed from library
    func retrieveFromParse(fileName: String) {
        let query = PFQuery(className: "\((PFUser.currentUser()?.username)!)_audioFiles")
        query.whereKey("audioName", equalTo: fileName)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            /*if error == nil {
                // :Mark, secondAudioFile is the audio file selected from Library. it is NSData, which can be easily played by AVAudioPlayer with play with data method
                object!["audioFile"].getDataInBackgroundWithBlock({ (data, error) -> Void in
                    if error == nil {
                        self.secondAudioFileData = data
                    } else {
                        print(error)
                    }
                })
            } else {
                print(error)
            }
            */
            print(object!["audioName"])

        }
    }
}
