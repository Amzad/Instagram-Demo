//
//  CameraViewController.swift
//  Instagram-Demo
//
//  Created by Amzad Chowdhury on 10/1/18.
//  Copyright © 2018 Amzad Chowdhury. All rights reserved.
//

import UIKit
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var tapLabel: UILabel!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        //vc.sourceType = UIImagePickerController.SourceType.camera
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        print("working")
        // Do something with the images (based on your use case)
        pickedImage.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        tapLabel.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didSubmit(_ sender: Any) {
        Post.postUserImage(image: pickedImage.image!, withCaption: captionField.text ?? "") { (success: Bool, error: Error?) in
            
        if success {
            self.tabBarController?.selectedIndex = 0
            self.captionField.text = ""
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAlert"), object: nil)
            //self.pickedImage.image = UIImage(named:)
            
        }
        else {
            print("Error. Unable to submit post")
        }
    }
    }
    
    
    func onDone() {
        
    }


}
