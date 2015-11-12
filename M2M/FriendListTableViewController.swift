//
//  FriendListTableViewController.swift
//  M2M
//
//  Created by Sheng-Hua.Lin on 11/10/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FriendListTableViewController: UITableViewController {
    
    var usernames : [String] = []
    var userIds : [String] = []
    var friendsList : [String] = []
    
    //var refresh_Control:UIRefreshControl!
    
    var selectedUser = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        let query = PFQuery(className: "userData")
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        
        query.getFirstObjectInBackgroundWithBlock ({ (object, error) -> Void in
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
        })
        
        /*
        let query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            if let users = objects {
                self.userIds.removeAll(keepCapacity: true)
                self.usernames.removeAll(keepCapacity: true)
        
                for object in users {
                    if let user = object as? PFUser {
                        if user.objectId! != PFUser.currentUser()?.objectId {
                            self.usernames.append(user.username!)
                            self.userIds.append(user.objectId!)
                        }
                    }
                }
            }
        self.tableView.reloadData()
        })
        */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendsList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendsListCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = friendsList[indexPath.row]
        
        let cellImage : UIImage = UIImage(named: "SampleProfileImage.png")!
        
        /*
        let query = PFQuery(className: "userData")
        query.whereKey("username", equalTo: usernames[indexPath.row])
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if error == nil {
                let image = PFImageView()
                image.file = object!["profileImage"] as? PFFile
                image.loadInBackground({ (photo, error) -> Void in
                    if error == nil {
                        cellImage = photo!
                    } else {
                        print(error)
                    }
                })
            } else {
                print(error)
            }
        }
        */

        
        
        cell.imageView?.image = cellImage

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedUser = friendsList[indexPath.row]
        performSegueWithIdentifier("viewFriendProfileSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "viewFriendProfileSegue"){
            
            let svc = segue.destinationViewController as! ViewFriendProfileViewController;
            svc.passedName = self.selectedUser;
            svc.isFollowing = true
        }
        
        /*if (segue.identifier == "viewFriendProfileSeaerchSegue"){
            
            let svc = segue.destinationViewController as! ViewFriendProfileViewController;
            svc.passedName = self.selectedUser;
            svc.isFollowing = false     //will cause friends that are searched to be false, need to fix!!
        }*/
        
    }
    
    func refresh(sender: AnyObject) {
        
        friendsList = []
        
        let query = PFQuery(className: "userData")
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        
        query.getFirstObjectInBackgroundWithBlock ({ (object, error) -> Void in
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
        })
        
        self.refreshControl?.endRefreshing()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
