//
//  UserProfileViewController.swift
//  M2M
//
//  Created by Sheng-Hua.Lin on 11/10/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class UserProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        performSegueWithIdentifier("logOutSegue", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.text = PFUser.currentUser()?.username
        
        let query = PFQuery(className: "userData")
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if error == nil {
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
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateProfilePicture(sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let query = PFQuery(className:"userData")
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if error == nil {
                object!["profileImage"] = PFFile(name: "userProfileImage", data: UIImageJPEGRepresentation(image, 0.5)!)
                object?.saveInBackground()
            } else {
                print(error)
            }
        }
        
        
        self.userProfileImage.image = image
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "logOutSegue"){
        
            let svc = segue.destinationViewController as! LoginViewController;
            svc.passedName = "no_UsEr";
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
