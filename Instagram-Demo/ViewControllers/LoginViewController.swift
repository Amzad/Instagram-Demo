//
//  LoginViewController.swift
//  Instagram-Demo
//
//  Created by Amzad Chowdhury on 10/1/18.
//  Copyright © 2018 Amzad Chowdhury. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 4
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.init(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        //signupButton.layer.borderColor = UIColor.cyan.cgColor

        loginButton.isEnabled = false
        signupButton.isEnabled = false
        brandImage.image = UIImage(named: "brand.svg")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        if ((loginField.text!.count > 0) && (passwordField.text!.count > 0)) {
            loginButton.isEnabled = true
            signupButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
            signupButton.isEnabled = false
        }
    }
    
  
    @IBAction func onSignIn(_ sender: Any) {
        let username = loginField.text ?? ""
        let password = passwordField.text ?? ""
            
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // display view controller that needs to shownafter successful login
            }
        }
    
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let newUser = PFUser()
        
        // set user properties
        newUser.username = loginField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
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
