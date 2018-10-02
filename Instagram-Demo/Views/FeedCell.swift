//
//  FeedCell.swift
//  Instagram-Demo
//
//  Created by Amzad Chowdhury on 10/2/18.
//  Copyright © 2018 Amzad Chowdhury. All rights reserved.
//

import UIKit
import Parse

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var photoView:  PFImageView!
    @IBOutlet weak var avatarView: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            self.photoView.file = instagramPost["image"] as? PFFile
            self.photoView.loadInBackground()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
