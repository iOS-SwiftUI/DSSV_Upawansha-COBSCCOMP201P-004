//
//  LocalUser.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import Foundation
import Firebase

struct LocalUser {
    static let shared = LocalUser()
    var username: String?

    private init() { }
    
    func checkLocalUser() -> Bool{
        if Auth.auth().currentUser != nil {
            
            print(Auth.auth().currentUser?.uid)
          // User is signed in.
            return true
        }
        return false
    }
}


