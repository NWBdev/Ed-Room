//
//  RegisterVC.swift
//  Ed Room
//
//  Created by Nathaniel Burciaga on 9/19/20.
//  Copyright © 2020 Appside of the Box. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {

    
    @IBOutlet weak var signup_First_Name_Field: UITextField!
    
    @IBOutlet weak var signup_Last_Name_Field: UITextField!
    
    @IBOutlet weak var signup_Email_Field: UITextField!
    
    @IBOutlet weak var signup_Password_Field: UITextField!
    
    @IBOutlet weak var agreeBtn: UIButton!
    
    
    @IBOutlet weak var signupBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Dark Mode
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        
        // Do any additional setup after loading the view.
        
        signup_First_Name_Field.delegate = self
        signup_First_Name_Field.delegate = self
        signup_Email_Field.delegate = self
        signup_Password_Field.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signupbtn_Was_Pressed(_ sender: Any) {
        loginBtnTapped()
    }
    
    
    func loginBtnTapped() {
        
        print("Login Btn Was Pressed")
        //Dismiss Fields
        signup_Email_Field.resignFirstResponder()
        signup_Password_Field.resignFirstResponder()
        signup_First_Name_Field.resignFirstResponder()
        signup_Last_Name_Field.resignFirstResponder()
        
        // Statement To make sure that info is correct or has stuff inside of it password as to be 6 or greater as well
        guard let email = signup_Email_Field.text,
              let firstName = signup_First_Name_Field.text,
              let lastName = signup_Last_Name_Field.text,
              let password = signup_Password_Field.text,
              !email.isEmpty,!firstName.isEmpty,!lastName.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        // Firebase Login Code
        
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
            print("enters Database Manager userExist Function")
            guard let strongSelf = self else {
                return
            }
            
            guard !exists else {
                //user already exist
                strongSelf.alertUserLoginError(message: "Looks like a user acount for that email address account already exist")
                return
            }
            
            //Firebase Register Code
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
               print("entered Created User")
                guard authResult != nil, error == nil else {
                    print("error creating user")
                    return
                }
                
               // let user = result.user
               // print("Created User: \(user)")
                print("Created user")
                DatabaseManager.shared.insertUser(with: EdRoomAppUser(firstName: firstName, lastName: lastName, emailAddress: email))
                
                strongSelf.presentingViewController?.dismiss(animated: false, completion: nil)
                strongSelf.presentingViewController?.dismiss(animated: true, completion: nil)

                
            })
        })
        
    }
        
    func alertUserLoginError(message: String = "Please enter all information to login.") {
            let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == signup_Email_Field {
            signup_Password_Field.becomeFirstResponder()
        }
        else if textField == signup_Password_Field {
            loginBtnTapped()
        }
        
        return true
    }
}

