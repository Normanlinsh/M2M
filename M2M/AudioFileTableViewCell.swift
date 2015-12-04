//
//  AudioFileTableViewCell.swift
//  M2M
//
//  Created by Mark Chae on 12/4/15.
//  Copyright © 2015 Lin. All rights reserved.
//

import UIKit

class AudioFileTableViewCell: UITableViewCell {
    
    @IBOutlet var Title: UILabel!
    
    @IBOutlet var Edit: UIButton!
    
    @IBOutlet var Delete: UIButton!
    
    @IBOutlet var Play: UIButton!
    
    //var AudioFile
    
    
    //@IBOutlet var Stop: UIButton!
    
   override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func Play(sender: UIButton) {
    }
    
    @IBAction func Append(sender: UIButton) {
    }
    
    @IBAction func Delete(sender: UIButton) {
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
