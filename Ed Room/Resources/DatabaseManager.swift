//
//  DatabaseManager.swift
//  Ed Room
//
//  Created by Nathaniel Burciaga on 11/9/20.
//  Copyright © 2020 Appside of the Box. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let databaseUsers = Database.database().reference().child("users")
    
    
    // QA TESTING
    public func test() {
        databaseUsers.child("foo").setValue(["something": true])
    }
    
    
}
    
// MARK: - Account CURRENT USER

extension DatabaseManager {
    
   // public func returnCurrentUserName(currentUser: String) -> String {
  // public func returnCurrentUserName(currentUser: String) -> String {
    public func printCurrentUserName() {
        let currentUserEmail = FirebaseAuth.Auth.auth().currentUser?.email
        
        var safeEmail = currentUserEmail?.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail?.replacingOccurrences(of: "@", with: "-")
        //if currentUser ==
        print("Current user: \(String(describing: safeEmail))")
        
        databaseUsers.child("user")
    
    
    //let databaseRef = Database.database().reference().child("Drinks")
    let query = databaseUsers.queryOrdered(byChild: "users").queryStarting(atValue: safeEmail).queryEnding(atValue: "\(String(describing: safeEmail))\\uf8ff")

            query.observeSingleEvent(of: .value) { (snapshot) in
                guard snapshot.exists() != false else { return }
                print("Print Query func: \(snapshot.value!)")
                DispatchQueue.main.async {
                    // Update TextFields here
                }
            }
    
    
    
    
    
    
    /*
    //ref.child("Users").queryOrderedByChild("name").queryStartingAtValue(text).queryEndingAtValue(text+"\u{f8ff}").observeEventType(.Value, withBlock: { snapshot in
            var user = User()
            var users = [User]()
            for u in snapshot.children{
                user.name = u.value!["name"] as? String
                ...
                users.append(user)
            }
            self.users = users
        })
     */
       // return currentUser
    }
       // End of Extentsion
}
    
    




    // MARK: - Account Management
    
    extension DatabaseManager {
        
        public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
            print("enters usersExists Function")
            var safeEmail = email.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            
            databaseUsers.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
                guard snapshot.value as? String != nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            })
            
        }
        
        /// Inserts new user to Database
        public func insertUser(with user: EdRoomAppUser) {
            databaseUsers.child(user.safeEmail).setValue([
                "first_name": user.firstName,
                "last_name": user.lastName
            ])
        }
        
    }

    
    
    
    struct EdRoomAppUser {
        let firstName: String
        let lastName: String
        let emailAddress: String
        
        // convert email to @ and .
        var safeEmail: String {
            var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            
            return safeEmail
        }
        
    }
    
    
