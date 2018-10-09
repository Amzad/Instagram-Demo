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
    @IBOutlet weak var posterLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    
    var instagramPost: PFObject! {
        didSet {
            let name = instagramPost["author"] as? PFUser
            self.posterLabel.text = name?.username
          
            self.photoView.file = instagramPost["postImage"] as? PFFile
            self.photoView.loadInBackground()

            self.avatarView.file = instagramPost["avatarImage"] as? PFFile
            self.avatarView.loadInBackground()

            self.captionLabel.text = instagramPost["caption"] as? String
            self.postLabel.text = name?.username
            
            let count = instagramPost["likesCount"] as? Int
            let count2 = count ?? 0
            self.likeLabel.text = String(count2) + " likes"
        
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
