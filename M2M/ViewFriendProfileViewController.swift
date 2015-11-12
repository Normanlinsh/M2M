//
//  ViewFriendProfileViewController.swift
//  M2M
//
//  Created by Sheng-Hua.Lin on 11/10/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewFriendProfileViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    var passedName = ""
    var isFollowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if passedName != "" {
            username.text = self.passedName     //passed username from prepareForSegue
        }
        
        //load profileImage from query from parse
        let query = PFQuery(className: "userData")
        query.whereKey("username", equalTo: username.text!)
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if error == nil {
                //if username exists in currentUser's friendList, set isFollowing to true
                if let friends = object!["friendList"] as? NSArray {
                    for friend in friends {
                        if friend as? String == self.username.text {
                            self.isFollowing = true
                            print(self.isFollowing)
                        }
                    }
                }

                
                
                //fetch image from parse
                let image = PFImageView()
                image.file = object!["profileImage"] as? PFFile
                image.loadInBackground({ (photo, error) -> Void in
                    if error == nil {
                        self.userProfileImage.image = photo!
                    } else {
                        print(error)
                    }
                })
            } else {
                print(error)
            }
        }
        
        print(isFollowing)
        
        //set the button title
        if isFollowing {
           addFriendButton.setTitle("Unfriend", forState: .Normal)
        } else {
            addFriendButton.setTitle("Friend", forState: .Normal)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var addFriendButton: UIButton!
    
    @IBAction func addFriend(sender: AnyObject) {
        
        let query = PFQuery(className: "userData")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username!)!)
        
        
        if isFollowing {
            
            query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
                if error == nil {
                    object?.removeObjectsInArray([self.username.text!], forKey: "friendList")
                    object?.saveInBackground()
                } else {
                    print(error)
                }
            }
            addFriendButton.setTitle("Friend", forState: .Normal)
            isFollowing = false
            
        } else {
            query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
                if error == nil {
                    object?.addObject(self.username.text!, forKey: "friendList")
                    object?.saveInBackground()
                } else {
                    print(error)
                }
            }
            addFriendButton.setTitle("Unfriend", forState: .Normal)
            isFollowing = true
        }
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
