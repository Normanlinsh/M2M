//
//  UserProfileViewController.swift
//  M2M
//
//  Created by Sheng-Hua.Lin on 11/10/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit
import Parse

class UserProfileViewController: UIViewController {
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userId: UILabel!
    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        performSegueWithIdentifier("logOutSegue", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.text = PFUser.currentUser()?.username

        // Do any additional setup after loading the view.
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
