//
//  DetailViewController.swift
//  Instagram-Demo
//
//  Created by Amzad Chowdhury on 10/9/18.
//  Copyright © 2018 Amzad Chowdhury. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {

    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var posterLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    var instagramPost: PFObject! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = instagramPost["author"] as? PFUser
        self.posterLabel.text = name?.username
        
        self.photoView.file = instagramPost["postImage"] as? PFFile
        self.photoView.loadInBackground()
        photoView.sizeToFit()
        
        self.captionLabel.text = instagramPost["caption"] as? String
        
        let count = instagramPost["likesCount"] as? Int
        let count2 = count ?? 0
        self.likeLabel.text = String(count2) + " likes"

        // Do any additional setup after loading the view.
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
