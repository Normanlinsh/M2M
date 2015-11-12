//
//  LoginViewController.swift
//  M2M
//
//  Created by Sheng-Hua.Lin on 11/10/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var login_signUp_button: UIButton!
    @IBOutlet weak var switchMode_button: UIButton!
    @IBOutlet weak var signUpDescription: UILabel!
    @IBOutlet weak var signUpDescription2: UILabel!
   
    var signUpActive = true
    
    var activitiyIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var currentUser : String = ""
    
    var passedName : String = ""
    
    @IBAction func login_signUp(sender: AnyObject) {
        
        if usernameText.text == "" || passwordText.text == "" {
                displayAlert("Error In Field", message: "Please enter a username and password")
        } else {
            
            if signUpActive == true {
                
                activitiyIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
                activitiyIndicator.center = self.view.center
                activitiyIndicator.hidesWhenStopped = true
                activitiyIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                view.addSubview(activitiyIndicator)
                activitiyIndicator.startAnimating()
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                
                let user = PFUser()
                user.username = usernameText.text
                user.password = passwordText.text
                
                var errorMsg = "Please Try Again Later"
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    
                    self.activitiyIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        //sign up successful
                        
                        let placeholderImage:UIImage = UIImage(named: "SampleProfileImage")!
                        
                        let userData = PFObject(className:"userData")
                        userData["profileImage"] = PFFile(name: "userProfileImage", data: UIImageJPEGRepresentation(placeholderImage, 0.5)!)
                        userData["friendList"] = []
                        userData["username"] = self.usernameText.text
                        //userData.ACL = PFACL.ACLWithUser(PFUser.currentUser()!)
                        userData.saveInBackgroundWithBlock {
                            (success: Bool, error: NSError?) -> Void in
                            if (success) {
                                self.currentUser = self.usernameText.text!
                            } else {
                                print(error)
                            }
                        }
                        
                        //self.currentUser = PFUser.currentUser()!
                        self.performSegueWithIdentifier("loginSegue", sender: self)
                        
                    } else {
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMsg = errorString
                        }
                            self.displayAlert("Failed Sign up", message: errorMsg)
                    }
                })
                
            } else {
                
                activitiyIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
                activitiyIndicator.center = self.view.center
                activitiyIndicator.hidesWhenStopped = true
                activitiyIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                view.addSubview(activitiyIndicator)
                activitiyIndicator.startAnimating()
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                
                
                PFUser.logInWithUsernameInBackground(usernameText.text!, password: passwordText.text!, block: { (user, error) -> Void in
                    
                    self.activitiyIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        //logged in
                        
                        //self.currentUser = PFUser.currentUser()!
                        self.performSegueWithIdentifier("loginSegue", sender: self)
                        
                        
                    } else {
                        var errorMsg = "Login failed"
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMsg = errorString
                        }
                            self.displayAlert("Failed Login", message: errorMsg)
                    }
                })
            }
        }
    }
    
    
    @available(iOS 8.0, *)
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func switchMode(sender: AnyObject) {
        
        if (signUpActive == true) {
            
            login_signUp_button.setTitle("Login", forState: UIControlState.Normal)
            switchMode_button.setTitle("Sign Up", forState: UIControlState.Normal)
            signUpDescription2.text = "Not Registered?"
            signUpDescription.text = "Login Below!"
            signUpActive = false
            
        } else {
            
            login_signUp_button.setTitle("Sign Up", forState: UIControlState.Normal)
            switchMode_button.setTitle("Login", forState: UIControlState.Normal)
            signUpDescription2.text = "Already Registered?"
            signUpDescription.text = "Sign Up Below!"
            signUpActive = true
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if passedName != ""  {
            currentUser = passedName
        }
        if PFUser.currentUser()?.username != nil {
            currentUser = (PFUser.currentUser()?.username)!
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if currentUser != "" && currentUser != "no_UsEr"{
            performSegueWithIdentifier("loginSegue", sender: self)
            //print(currentUser)
            //print(passedName)
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
