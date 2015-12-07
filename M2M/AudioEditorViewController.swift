//
//  AudioEditorViewController.swift
//  M2M
//
//  Created by Mark Chae on 11/11/15.
//  Copyright (c) 2015 Lin. All rights reserved.
//

import AudioToolbox
import AVFoundation
import UIKit
import Parse

class AudioEditorViewController: UIViewController, AVAudioPlayerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var player : AVAudioPlayer!
    var secondAudioFileData : NSData!
    var fromLibrary = false
    var fromLibraryFileName = ""
    
    var url:NSURL!
    
    @IBOutlet var Play: UIButton!
    
    @IBOutlet var Stop: UIButton!
    
    @IBOutlet var Edit: UIButton!
    
    @IBOutlet var Delete: UIButton!
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        return cell as UITableViewCell
    }
    //Slide to delete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            //.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func createTableMenu() {
        //Create alert/action sheet menu with all files as options
    }
    
    func append(audio1: NSURL, audio2:  NSURL) {
        /*
        let composition = AVMutableComposition()
        var track1:AVMutableCompositionTrack = composition.addMutableTrackWithMediaType(AVMediaTypeAudio,
            preferredTrackID: CMPersistentTrackID())
        var track2:AVMutableCompositionTrack = composition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        
        var documentDirectoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! 
        var fileDestinationUrl = documentDirectoryURL.URLByAppendingPathComponent(" ")
        print(fileDestinationUrl)
        
        
        var url1 = audio1
        var url2 = audio2
        
        
        var avAsset1 = AVURLAsset(URL: url1, options: nil)
        var avAsset2 = AVURLAsset(URL: url2, options: nil)
        
        var tracks1 =  avAsset1.tracksWithMediaType(AVMediaTypeAudio)
        var tracks2 =  avAsset2.tracksWithMediaType(AVMediaTypeAudio)
        
        var assetTrack1:AVAssetTrack = tracks1[0]
        var assetTrack2:AVAssetTrack = tracks2[0]
        
        
        var duration1: CMTime = assetTrack1.timeRange.duration
        var duration2: CMTime = assetTrack2.timeRange.duration
        
        var timeRange1 = CMTimeRangeMake(kCMTimeZero, duration1)
        var timeRange2 = CMTimeRangeMake(duration1, duration2)
        
        do {
            try track1.insertTimeRange(timeRange1, ofTrack: assetTrack1, atTime: kCMTimeZero)
            try track2.insertTimeRange(timeRange2, ofTrack: assetTrack2, atTime: duration1)
        }
        catch _ {
        }
        
        var assetExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)
        assetExport!.outputFileType = AVFileTypeAppleM4A
        assetExport!.outputURL = fileDestinationUrl
        assetExport!.exportAsynchronouslyWithCompletionHandler({
            switch assetExport!.status{
            case  AVAssetExportSessionStatus.Failed:
                print("Failed \(assetExport!.error)")
            case AVAssetExportSessionStatus.Cancelled:
                print("Cancelled \(assetExport!.error)")
            default:
               print("Success")
            //Add new file to library, unfinished
            }
            
        })
        */
    }
    
    func overlay(audio1: NSURL, audio2:  NSURL) {
        
    }
    
    
    @IBAction func Play(sender: UIButton) {
        //open table menu...
        //play item from table menu
    }
    
    @IBAction func Edit(sender: UIButton) {
        let alert = UIAlertController(title: "Edit", message: nil,
            preferredStyle: .ActionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) {(action) in}
        alert.addAction(cancel)
        let append = UIAlertAction(title: "Append", style: .Default) {(action) in
            //open table menu...
            //item1=file at index
            //open table menu again without item1
            //item2=file at index
            //call append()
            //add new item to table
        }
        alert.addAction(append)
        let overlay = UIAlertAction(title: "Overlay", style: .Default) {(action) in
            //open table menu...
            //item1=file at index
            //open table menu again without item1
            //item2=file at index
            //call overlay()
            //add new item to table
        }
        alert.addAction(overlay)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func Delete(sender: UIButton) {
        //open table menu...
        //play item from table menu
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
