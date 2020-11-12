//
//  RoomsVC.swift
//  Ed Room
//
//  Created by Nathaniel Burciaga on 10/10/20.
//  Copyright © 2020 Appside of the Box. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import JGProgressHUD


class RoomsVC: UIViewController {

    // MARK: - Outlets/ Variables

    //Outlets
    @IBOutlet weak var nameOfUserTitle: UILabel!
    
    @IBOutlet weak var roomsTableView: UITableView!
    
    @IBOutlet weak var signout_Btn: UIButton!
    
    // Variable that displays users First Name on RoomsVC
    var tempValueFirstName = ""
    // TEST name variable
    var nameGlobal = ""
    
    var edroomStudGlobal = ""
    
    //
    var usersClassesNames = [String]()
    
    var usersClassesTeachers = [String]()

    var userclassCount = 0
    
    //Spinner
    private let spinner = JGProgressHUD()
    
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dark Mode
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        
        //roomsTableView.delegate = self
        //roomsTableView.dataSource = self
        // TEST VIEW FOR AUTH SERVICE WORKING
        //view.backgroundColor = .green
        

    /*
    //let databaseRef = Database.database().reference().child("Drinks")
    let query = databaseUsersRef.queryOrdered(byChild: "users").queryStarting(atValue: safeEmail).queryEnding(atValue: "\(String(describing: safeEmail))\\uf8ff")
            
            query.observeSingleEvent(of: .value) { (snapshot) in
                print("Testing Snapshot: \(snapshot.value!)")
                guard snapshot.exists() != false else {
                    print("Doesnt Exist")
                    return }
                print("Print Query func: \(snapshot.value!)")
                DispatchQueue.main.async {
                    // Update TextFields here
                }
            }
        */
    
        // TEST DB REALTIME
        //DatabaseManager.shared.test()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - ViewDidAppear

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - validateAuth Call
        validateAuth()
        
        
        // MARK: - Set User Name Title/ Currenct user account
        let currentUserEmail = FirebaseAuth.Auth.auth().currentUser?.email
        
        var safeEmailCurrent = currentUserEmail?.replacingOccurrences(of: ".", with: "-")
        safeEmailCurrent = safeEmailCurrent?.replacingOccurrences(of: "@", with: "-")
        //if currentUser ==
        print("Print Current user: \(String(describing: safeEmailCurrent))")
                
        //databaseUsers.child("user")
        let databaseUsersRef = Database.database().reference().child("users")
        //let databaseUsersRef = Database.database().reference()

        // Gets Snapshot Key Value
        databaseUsersRef.observeSingleEvent(of: .value, with: { (snap : DataSnapshot)  in
            print("Print Enter Observer Users")
                for child in snap.children {
                    let key = (child as AnyObject).key as String
                    print("Print Key: \(key)")
                    for child in snap.children { //even though there is only 1 child
                                let snap = child as! DataSnapshot
                                let dict = snap.value as! [String: Any]
                                let name = dict["first_name"] as? String ?? ""
                               // let owner = dict["last_name"] as? String ?? ""
                        self.nameGlobal = name
                                //print("Print first: \(name) last: \(owner)")
                        /*
                        if key == safeEmailCurrent {
                            /*get key
                            users
                                nate <---
                                    first
                                    last
                            */
                            //self.tempValueFirstName = key
                            self.tempValueFirstName = name
                            
                            print("Print TempvalueFirstName: \(self.tempValueFirstName)")
                            self.nameOfUserTitle.text = self.tempValueFirstName


                        }
                        */
                            }
                    
                    if key == safeEmailCurrent {
                        /*get key
                        users
                            nate <---
                                first
                                last
                        */
                        //self.tempValueFirstName = key
                        
                        let snap = child as! DataSnapshot
                        let dict = snap.value as! [String: Any]
                        let name = dict["first_name"] as? String ?? ""
                        self.tempValueFirstName = name
                        
                        print("Print TempvalueFirstName: \(self.tempValueFirstName)")
                        self.nameOfUserTitle.text = self.tempValueFirstName


                    }
                    
                }
            }) { (err: Error) in
                print("\(err.localizedDescription)")
            }
        
        
        
        
        // MARK: - Adding Ed Rooms TBV
        
        //check what classes the user has

        
        let databaseEdRoomRef = Database.database().reference().child("edrooms")
        print("Print Created Observer Edrooms: \(databaseEdRoomRef)")

        //let roomsUsersRef = self.ref.child("rooms")
        //let queryRef = databaseEdRoomRef.queryOrdered(byChild: "students/").queryEqual(toValue: true)
       // self.userclassCount = 0
        //self.userclassCount = 0

        databaseEdRoomRef.observeSingleEvent(of: .value, with: { (snap : DataSnapshot)  in
            //print("Print Enter Observer Edrrom")
                for child in snap.children {
                    let key = (child as AnyObject).key as String
                    print("Print KeyEdroom LV1: \(key)")
                    let keyRef = Database.database().reference().child("edrooms").child(key)
                    keyRef.observeSingleEvent(of: .value, with: { (snapNest : DataSnapshot)  in
                        //print("Print Enter Observer Edrrom")
                            for child in snapNest.children {
                                let keyNest = (child as AnyObject).key as String
                                print("Print KeyEdroom LV2: \(keyNest)")
                                
                                if keyNest == "students" {
                                    let keyStdRef = Database.database().reference().child("edrooms").child(key).child(keyNest)
                                    keyStdRef.observeSingleEvent(of: .value, with: { (snapNestLV2 : DataSnapshot)  in
                                        for child in snapNestLV2.children {
                                            let keyNestLV2 = (child as AnyObject).key as String
                                            print("Print KeyNestEdroom LV3: \(keyNestLV2)")
                                            
                                            //Prints std_ values
                                            let dictEmail = snapNestLV2.value as! [String: Any]
                                            let emailED = dictEmail[keyNestLV2] as! String
                                            print("Print Dict Email LV3: \(emailED)")
                                            //print("Print \(String(describing: safeEmailCurrent))) Edroom Finder")
                                            
                                            let currentUserEmailEDRoom = FirebaseAuth.Auth.auth().currentUser?.email
                                            
                                            var safeEmailCurrentEdRoom = currentUserEmailEDRoom?.replacingOccurrences(of: ".", with: "-")
                                            safeEmailCurrentEdRoom = safeEmailCurrentEdRoom?.replacingOccurrences(of: "@", with: "-")
                                            print("Print CURRENT USER EDROOM: \(String(describing: safeEmailCurrentEdRoom))) Edroom Finder")

                                            if emailED == safeEmailCurrentEdRoom{
                                                print("Print STUDENT: \(emailED) IS IN CLASS \(key)")
                                                //self.userclassCount = self.userclassCount + 1
                                                //print("PRINT COUNT: \(self.userclassCount)")
                                                self.userclassCount = self.userclassCount + 1
                                                print("PRINT COUNT: \(self.userclassCount)")
                                                self.roomsTableView.reloadData()

                                                
                                            } else {
                                                //print("Print STUDENT: \(emailED) Is NOT in class \(key)")

                                            }
                                            
                                            //self.tempValueFirstName = name
                                        }
                                    })
                                    
                                }
                                    
                            }
                        })
                }

            self.spinner.show(in: self.view)
            //DELGATES AND DATASOURCE HAS TO BE HERE DUE TO ASYCH DB
            self.roomsTableView.delegate = self
            self.roomsTableView.dataSource = self
            
            DispatchQueue.main.async {
                self.spinner.dismiss()

            }
            
            }) { (err: Error) in
                print("\(err.localizedDescription)")
            }
        
        /*
        // Gets Snapshot Key Value
        databaseEdRoomRef.observeSingleEvent(of: .value, with: { (snap : DataSnapshot)  in
                for child in snap.children {
                    print("Print Enter Observer Edrooms")
                    let key = (child as AnyObject).key as String
                    print("Print Edroom Key: \(key)")
                    for child in snap.children { //even though there is only 1 child
                        print("Print snap child: \(snap.children)")
                                let snap = child as! DataSnapshot
                                let dict = snap.value as! [String: Any]
                                let stud = dict["students"] as? String ?? ""
                        self.edroomStudGlobal = stud
                                print("Print Students: \(stud)")
                            }
                    
                    //get to current user
                    /*
                    if key == safeEmailCurrent {
                        /*get key
                        users
                            nate <---
                                first
                                last
                        */
                        //self.tempValueFirstName = key
                        
                        let snap = child as! DataSnapshot
                        let dict = snap.value as! [String: Any]
                        let name = dict["first_name"] as? String ?? ""
                        self.tempValueFirstName = name
                        
                        print("Print TempvalueFirstName: \(self.tempValueFirstName)")
                        self.nameOfUserTitle.text = self.tempValueFirstName


                    }
                    */
                    
                }
            }) { (err: Error) in
                print("\(err.localizedDescription)")
            }

        */
        
        /*
         // TEST SECTIONS
         for child in snap.children { //even though there is only 1 child
                     let snap = child as! DataSnapshot
                     let dicted = snap.value as! [String: Any]
                     let name = dicted["students"] as? String ?? ""
                     print("Print snap Edroom LV2: \(snap)")

                     print("Print snap Edroom name: \(name)")
             
                 }
        */
        
        
        
        // TEST SECTION NOT IMPORTANT JUST FOR REFERECNCE
        /*
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn {
           // let vc = LoginVC()
            
            //Login_VC
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let linkingVC = storyboard.instantiateViewController(withIdentifier: "Login_VC")
            linkingVC.modalPresentationStyle = .fullScreen
            present(linkingVC, animated: false, completion: nil)
            //self.definesPresentationContext = true
            //let nav = UINavigationController(rootViewController: vc)
            // let nav = UIViewController(rootViewController: vc)
            //nav.modalPresentationStyle = .fullScreen
            //let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("LoginVC") as ResultViewController
            //vc.modalPresentationStyle = .fullScreen
            //present(vc, animated:false)
        }
        */
        
        
        
    }

    
    // MARK: - validateAuth Function
    private func validateAuth() {
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
           // let vc = LoginVC()
            
            //Login_VC
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let linkingVC = storyboard.instantiateViewController(withIdentifier: "Login_VC")
            linkingVC.modalPresentationStyle = .fullScreen
            present(linkingVC, animated: false, completion: nil)
            //self.definesPresentationContext = true
            //let nav = UINavigationController(rootViewController: vc)
            // let nav = UIViewController(rootViewController: vc)
            //nav.modalPresentationStyle = .fullScreen
            //let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("LoginVC") as ResultViewController
            //vc.modalPresentationStyle = .fullScreen
            //present(vc, animated:false)
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
    
    // MARK: - IBActions

    @IBAction func signout_Btn_Was_Pressed(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { [weak self] _ in
            
            guard let strongSelf = self else {
                return
            }
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                //Login_VC
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let linkingVC = storyboard.instantiateViewController(withIdentifier: "Login_VC")
                linkingVC.modalPresentationStyle = .fullScreen
                strongSelf.present(linkingVC, animated: false, completion: nil)
            }
            catch {
                print("failed to logout")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
        
    }
    
}


// MARK: - TableView

extension RoomsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("test tap")
    }
}


extension RoomsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Print UITABLE")

        print("Print UITABLE COUNT: \(userclassCount)")
        return userclassCount
        // something.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath)
        
        //cell.textLabel?.text = names[index.row]
        
        return cell
    }
}
