//
//  FeedViewController.swift
//  Instagram-Demo
//
//  Created by Amzad Chowdhury on 9/27/18.
//  Copyright © 2018 Amzad Chowdhury. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navController = navigationController!
        let image = #imageLiteral(resourceName: "brand.svg")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        /**
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query!.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if let objects = objects {
                self.posts = objects
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }**/
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getFeedUpdate() {
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        cell.instagramPost = posts[indexPath.row]
        return cell
        
    }


}

