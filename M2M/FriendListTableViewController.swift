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
    
    //var usernames : [String] = []
    //var userIds : [String] = []
    var friendsList : [String] = []
    var friendsImage : [UIImage] = []
    
    //var refresh_Control:UIRefreshControl!
    
    var selectedUser = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //tableView.reloadData()
        print("here again")
        
        //pull to refresh
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        //the following query attempts to store current user's friendlist and present it to table view
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
        
        //place holder image
        let cellImage : UIImage = UIImage(named: "SampleProfileImage.png")!
        
        //the following query attempts to fetch the profileImage from each cell's user and place it next to the cell
        /*let query = PFQuery(className: "userData")
        query.whereKey("username", equalTo: self.friendsList[indexPath.row])
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if error == nil {
                let image = PFImageView()
                image.file = object!["profileImage"] as? PFFile
                image.loadInBackground({ (photo, error) -> Void in
                    if error == nil {
                        cellImage = photo!
                        cell.imageView?.image = cellImage
                        self.doSomethingAtClosure()
                    } else {
                        print(error)
                    }
                })
            } else {
                print(error)
            }
        }*/
        
        cell.imageView?.image = cellImage
        
        return cell
    }
    
    func doSomethingAtClosure() {
        self.tableView.reloadData()
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedUser = friendsList[indexPath.row]
        performSegueWithIdentifier("viewFriendProfileSegue", sender: self)
    }
    
    //pass selected user information to the next view
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
    
    //pull to refresh function
    func refresh(sender: AnyObject) {
        
        //clear the friend list to repopulate it
        friendsList = []
        
        //repopulate the new friendlist, there's definitely a more efficient way to do this, but i'm too lazy...
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
            //reload the tableview with the new friendlist
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
