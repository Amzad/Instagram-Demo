import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    @NSManaged var postImage : PFFile
    @NSManaged var avatarImage : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Post"
    }
    
    /**
     * Other methods
     */
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, avatar: UIImage? = UIImage(named: "avatar-placeholder"), withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let post = Post()
        
        // Add relevant fields to the object
        post.postImage = getPFFileFromImage(image: image)!
        post.avatarImage = getPFFileFromImage(image: avatar)!
        post.author = PFUser.current()!
        post.caption = caption!
        let number = Int.random(in: 0 ... 10)
        let commentNumber = Int.random(in: 20 ... 200)
        post.likesCount = number
        post.commentsCount = commentNumber
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = image.pngData() {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
