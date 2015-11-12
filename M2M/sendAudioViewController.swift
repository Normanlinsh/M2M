//
//  sendAudioViewController.swift
//  M2M
//
//  Created by Sheng-Hua.Lin on 11/11/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit
import Parse

class sendAudioViewController: UIViewController {
    
    var audioFile = "String" //placeholder
    var receiver = "" //placeholder
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendFile() {
        
        let audioToSend = PFObject(className: "sentAudioFiles")
        
        // audioToSend["audio"] = PFFile(name: "audio.mp3", contentsAtPath: audioFile)
        audioToSend["senderUsername"] = PFUser.currentUser()?.username
        audioToSend["receiverUsername"] = receiver

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
