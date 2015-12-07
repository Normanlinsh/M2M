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

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addFileButton: UIBarButtonItem!
    
    var data : [String] = []
    var data0 : [String] = []
    var data1 : [String] = []
    
    var audioFiles : [PFFile] = []
    var audioData : [NSData] = []
    
    var fromEditor = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        //data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
        //data0 = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
        
        let query = PFQuery(className: "\((PFUser.currentUser()?.username)!)_audioFiles")
        query.whereKey("ownerUserName", equalTo: (PFUser.currentUser()?.username)!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects!{
                    self.data1.append(String(object["audioName"]))
                    let file = object["audioFile"] as! PFFile
                    self.audioFiles.append(file)
                }
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
    
    
    @IBAction func addFile(sender: AnyObject) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
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
        //let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        //print(indexPath.row)
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
        
        audioFiles[index].getDataInBackgroundWithBlock { (audioData: NSData?, error: NSError?) -> Void in
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
    
    func valueChanged(segmentedControl: UISegmentedControl) {
        //print("Coming in : \(segmentedControl.selectedSegmentIndex)")
        
        if(segmentedControl.selectedSegmentIndex == 0){
            self.data = self.data0
        } else {
            self.data = data1
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
        query.whereKey("ownerUserName", equalTo: (PFUser.currentUser()?.username)!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects!{
                    self.data1.append(String(object["audioName"]))
                    let file = object["audioFile"] as! PFFile
                    self.audioFiles.append(file)
                }
            } else {
                print(error)
            }
            self.tableView.reloadData()
        }
        
        self.refreshControl?.endRefreshing()
    }

    override func viewWillAppear(animated: Bool) {
        //refresh(self)
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
