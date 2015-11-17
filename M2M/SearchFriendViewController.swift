//
//  SearchFriendViewController.swift
//  M2M
//
//  Created by Sheng-Hua.Lin on 11/10/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class SearchFriendViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchActive : Bool = false
    //var data : [String] = ["elephant", "tiger", "lion", "mouse", "horse", "zebra", "crocodile"]
    var data : [String] = []
    var filtered : [String] = []
    
    var selectedUser = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the following query fetch all the users from Parse and store them in data[]
        let query = PFUser.query()
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            if let users = objects {
                
                for object in users {
                    if let user = object as? PFUser {
                        if user.objectId! != PFUser.currentUser()?.objectId {
                            self.data.append(user.username!)
                        }
                    }
                }
            }
        })
        // Do any additional setup after loading the view.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText : String) {
        
        // filters the data from data[] (by the userinput in searchbar)
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0) {
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*if (searchActive) {
        return filtered.count
        }
        
        return data.count*/
        return filtered.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendSearchCell")! as UITableViewCell;
        
        /*if(searchActive) {
        cell.textLabel?.text = filtered[indexPath.row]
        } else {
        cell.textLabel?.text = data[indexPath.row]
        }*/
        cell.textLabel?.text = filtered[indexPath.row]
        
        
        let cellImage : UIImage = UIImage(named: "SampleProfileImage.png")!
        
        //the following query attempts to fetch the profileImage from each cell's user and place it next to the cell
        /*
        let query = PFQuery(className: "userData")
        query.whereKey("username", equalTo: self.filtered[indexPath.row])
        
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
        }
        */
        
        cell.imageView?.image = cellImage
        
        return cell
    }
    
    func doSomethingAtClosure() {
        self.tableView.reloadData()
        
    }
    
    // function to perform segue when a cell is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedUser = indexPath.row
        performSegueWithIdentifier("viewFriendProfileSearchSegue", sender: self)
        
    }
    
    // function to pass information about the selected user to the new viewUserProfileViewController view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "viewFriendProfileSearchSegue"){
            
            let svc = segue.destinationViewController as! ViewFriendProfileViewController;
            svc.passedName = filtered[selectedUser];
            svc.isFollowing = false
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
