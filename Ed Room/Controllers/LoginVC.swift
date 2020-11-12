//
//  LoginVC.swift
//  Ed Room
//
//  Created by Nathaniel Burciaga on 9/19/20.
//  Copyright © 2020 Appside of the Box. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    
    @IBOutlet weak var emails_field: UITextField!
    
    @IBOutlet weak var password_Field: UITextField!
    
    @IBOutlet weak var signin_Btn: UIButton!
    
    @IBOutlet weak var signup_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Dark Mode
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        
        // Do any additional setup after loading the view.
        
        //title = "Log In"
        //view.backgroundColor = .white
        
        emails_field.delegate = self
        password_Field.delegate = self
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done,target: self, action: #selector(didTapRegister))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signinBtn_was_Pressed(_ sender: Any) {
        loginBtnTapped()
    }
 
    
    @IBAction func signupBtn_was_Pressed(_ sender: Any) {
        didTapRegister()
    }
    
    
    func loginBtnTapped() {
        
        emails_field.resignFirstResponder()
        password_Field.resignFirstResponder()
        
        // Statement To make sure that info is correct or has stuff inside of it password as to be 6 or greater as well
        guard let email = emails_field.text, let password = password_Field.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        //Firebase Login Code
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email: \(email)")
                return
            }
            
            let user = result.user
            print("Logged In User: \(user)")
            strongSelf.presentingViewController?.dismiss(animated: true, completion: nil)
        })
        
    }
    
    // Alert function to alert user info is wrong
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to login.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func didTapRegister() {
        //Login_VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let linkingVC = storyboard.instantiateViewController(withIdentifier: "Register_VC")
        linkingVC.modalPresentationStyle = .fullScreen
        present(linkingVC, animated: false, completion: nil)
    }

}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emails_field {
            password_Field.becomeFirstResponder()
        }
        else if textField == password_Field {
            loginBtnTapped()
        }
        
        return true
    }
}







