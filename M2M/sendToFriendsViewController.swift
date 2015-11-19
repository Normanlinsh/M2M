//
//  sendToFriendsViewController.swift
//  M2M
//
//  Created by Sheng-Hua.Lin on 11/18/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class sendToFriendsViewController: UIViewController {
    
    var friendsList : [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func send(sender: AnyObject) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFQuery(className: "userData")
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if error == nil {
                if let friends = object!["friendList"] as? NSArray {
                    for friend in friends {
                        self.friendsList.append(friend as! String)
                    }
                }
            } else {
                print(error)
            }
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("sendToFriendsCell")! as UITableViewCell;
        
        cell.textLabel?.text = friendsList[indexPath.row]
        
        return cell
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
