//
//  ViewController.swift
//  Firebase_Social
//
//  Created by Surachet Songsakaew on 11/23/2559 BE.
//  Copyright © 2559 Surachet Songsakaew. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper


class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
           print("ID Found in keychain")
            performSegue(withIdentifier: "gotoFeed", sender: nil)

        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self ){(result,error) in
        
            if error != nil {
                print("Unable to Facebook")
            } else if result?.isCancelled == true {
                print("User cancelled ")
            } else {
                print("Successfuly authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    
    func firebaseAuth(_ credential:FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate with Firebase -\(error)")
            } else {
                print("LogIn with Facebook Successfuly authenticated with Firebase")
                
                if let user = user {
                    let userData = ["provider":credential.provider]
                     self.completeSignIn(id: user.uid,userData:userData)
                }
            }
            
            
        })
    }
    
    @IBAction func signInTapped(_ sender: AnyObject) {
        let email = emailField.text!
        let password = passwordField.text!

         if email != "" && password != "" {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("JESS: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("JESS: Unable to authenticate with Firebase using email")
                            print("\(error)")
                        } else {
                            print("JESS: Successfully authenticated with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
            
        }
    }
    

    
    
    func completeSignIn(id:String,userData:Dictionary<String,String>) {
        DataService.de.createFirbaseDBUser(uid: id, userData: userData)
        
        
        let keyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Data save to -----> \(keyChainResult)")
        
        performSegue(withIdentifier: "gotoFeed", sender: nil)

    }
    
    

}

