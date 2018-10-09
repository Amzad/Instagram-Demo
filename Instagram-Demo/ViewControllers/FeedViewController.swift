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
    @objc let refreshControl = UIRefreshControl()
    
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    override func viewDidLoad() {
        
        // infinity scrolling
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
        
        
        //auto refresh after submitting new post
        NotificationCenter.default.addObserver(self, selector: #selector(getFeedUpdate), name: NSNotification.Name(rawValue: "showAlert"), object:  nil)
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        
        // navtitle bar image
        let navController = navigationController!
        let image = #imageLiteral(resourceName: "brand.svg")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        
        // table setup
        navigationItem.titleView = imageView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 331
        
        getFeedUpdate()

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                getFeedUpdate()
                
            }
        }
    }
    
    func loadMoreData() {
            // Update flag
            self.isMoreDataLoading = false
            
            // Stop the loading indicator
            self.loadingMoreView!.stopAnimating()
            
            // ... Use the new data to update the data source ...
            
            // Reload the tableView now that there is new data
            self.tableView.reloadData()
 
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        getFeedUpdate()
    }
    
    @objc func getFeedUpdate() {
        refreshControl.beginRefreshing()
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        //query?.limit = 20
        
        // fetch data asynchronously
        query!.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                self.posts.removeAll()
                if let feedObjects = objects {
                    for feed in feedObjects {
                        self.posts.append(feed)
                        //print(feed["author"] as? PFFile);
                        print("Feed visiable")
                    }
                }
            }
            else {
                print(error?.localizedDescription)
            }
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
        refreshControl.endRefreshing()
        self.loadingMoreView?.stopAnimating()
        self.isMoreDataLoading = false
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        cell.instagramPost = posts[indexPath.row]
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let post = self.posts[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.instagramPost = post
        }
    }

}

