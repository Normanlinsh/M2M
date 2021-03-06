//
//  MusicLibraryViewController.swift
//  M2M
//
//  Created by Sheng-Hua.Lin on 11/10/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import AVFoundation

class MusicLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate{
    
    var player:AVAudioPlayer!
    var refreshControl:UIRefreshControl!
    var selectedFileIndexRow : Int = -1
    var selectedFileIndexPath : NSIndexPath!
    var previouslySelectedFileIndexPath : NSIndexPath!
    var currentCategory = 0

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addFileButton: UIBarButtonItem!
    
    var data : [String] = []
    var data0 : [String] = []
    var data1 : [String] = []
    
    var audioFiles0 : [PFFile] = []
    var audioFiles1 : [PFFile] = []
    var audioData : [NSData] = []
    var newFiles : Int = 0
    var point : Int = 0
    
    var fromEditor = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        let tabItem = tabArray.objectAtIndex(1) as! UITabBarItem
        tabItem.badgeValue = nil
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        let query = PFQuery(className: "\((PFUser.currentUser()?.username)!)_audioFiles")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects!{
                    if object["author"] as! String == (PFUser.currentUser()?.username)! {
                        self.data1.append(String(object["audioName"]))
                        let file = object["audioFile"] as! PFFile
                        self.audioFiles1.append(file)
                    } else {
                        self.data0.append(String(object["audioName"]))
                        let file = object["audioFile"] as! PFFile
                        self.audioFiles0.append(file)
                    }
                }
            } else {
                print(error)
            }
        }
        
        print((PFUser.currentUser()?.username)!)
        let deleteQuery = PFQuery(className: "sentAudioFiles")
        deleteQuery.whereKey("receiverUsername", equalTo: (PFUser.currentUser()?.username)!)
        deleteQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects!{
                    //object["notified"] = true
                    object.deleteInBackground()
                }
            } else {
                print(error)
            }
        }

        let addPoints = PFQuery(className: "userData")
        addPoints.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        addPoints.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if error == nil {
                self.point = object!["points"] as! Int
                self.point = self.point + (5 * self.newFiles)
                print(self.point)
                object!["points"] = self.point
                object?.saveInBackground()
            } else {
                print(error)
            }
        }
        
        if fromEditor
        {
            self.navigationItem.rightBarButtonItem = self.addFileButton
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("musicLibraryCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        //let image = UIImage(named: "FriendListIcon")
        //cell.imageView?.image = image
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // if segued to library from editor, allow selecting function
        if fromEditor {
            let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            if previouslySelectedFileIndexPath == nil {
                previouslySelectedFileIndexPath = indexPath
            } else {
                previouslySelectedFileIndexPath = selectedFileIndexPath
                let previouslySelectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(previouslySelectedFileIndexPath)!
                previouslySelectedCell.accessoryType = UITableViewCellAccessoryType.None
            }
            selectedFileIndexPath = indexPath
            selectedFileIndexRow = indexPath.row
            selectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            //importAudio(self)
        }

        //play audio at selected cell
        play(indexPath.row)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let control = UISegmentedControl(items: ["Received Recordings","Your Recordings"])
        control.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        if(section == 0){
            return control;
        }
        return nil;
    }
    
    func play(index:Int) {
        
        if currentCategory == 0 {
            audioFiles0[index].getDataInBackgroundWithBlock { (audioData: NSData?, error: NSError?) -> Void in
                do {
                    try self.player = AVAudioPlayer(data: audioData!, fileTypeHint: AVFileTypeAppleM4A)
                    self.player.prepareToPlay()
                    self.player.volume = 1.0
                    self.player.play()
                }
                catch let error as NSError {
                    self.player = nil
                    print(error.localizedDescription)
                }
            }
        } else {
            audioFiles1[index].getDataInBackgroundWithBlock { (audioData: NSData?, error: NSError?) -> Void in
                do {
                    try self.player = AVAudioPlayer(data: audioData!, fileTypeHint: AVFileTypeAppleM4A)
                    self.player.prepareToPlay()
                    self.player.volume = 1.0
                    self.player.play()
                }
                catch let error as NSError {
                    self.player = nil
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func importAudio(sender: AnyObject) {
        //var controller: UINavigationController
        //controller = self.storyboard?.instantiateViewControllerWithIdentifier("NavigationVCIdentifierFromStoryboard") as! UINavigationController
        //controller = self.storyboard?.
        //controller.yourTableViewArray = localArrayValue
        //navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if (segue.identifier == "libraryToEditorSegue"){
            let svc = segue.destinationViewController as! AudioEditorViewController;
            svc.fromLibrary = true
            if currentCategory == 0 {
                svc.fromLibraryFileName = data0[selectedFileIndexRow]
            } else {
                svc.fromLibraryFileName = data1[selectedFileIndexRow]
            }
        //}
    }
    
    
    func valueChanged(segmentedControl: UISegmentedControl) {

        
        if(segmentedControl.selectedSegmentIndex == 0){
            self.data = self.data0
            currentCategory = 0
        } else {
            self.data = data1
            currentCategory = 1
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func refresh(sender: AnyObject) {
        
        //clear the data list to repopulate it
        
        data1 = []
        
        //repopulate the new friendlist, there's definitely a more efficient way to do this, but i'm too lazy...
        let query = PFQuery(className: "\((PFUser.currentUser()?.username)!)_audioFiles")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects!{
                    self.data1.append(String(object["audioName"]))
                    let file = object["audioFile"] as! PFFile
                    self.audioFiles1.append(file)
                }
            } else {
                print(error)
            }
            self.tableView.reloadData()
        }
        
        self.refreshControl?.endRefreshing()
    }

    override func viewWillAppear(animated: Bool) {
        
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
