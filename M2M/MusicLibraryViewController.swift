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

class MusicLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addFileButton: UIBarButtonItem!
    
    var data : [String] = []
    var data0 : [String] = []
    var data1 : [String] = []
    
    var fromEditor = false
    
   // //var selectedCells : Dictionary<String, > = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]

        data0 = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
        
        data1 = ["Data1","Data11","Data111"]
        
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
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let control = UISegmentedControl(items: ["Saved Recordings","New Recordings"])
        control.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        if(section == 0){
            return control;
        }
        return nil;
    }
    
    func valueChanged(segmentedControl: UISegmentedControl) {
        //print("Coming in : \(segmentedControl.selectedSegmentIndex)")
        
        if(segmentedControl.selectedSegmentIndex == 0){
            self.data = self.data0
        } else if(segmentedControl.selectedSegmentIndex == 1){
            self.data = self.data1
        } else {
            self.data = data0
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
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
