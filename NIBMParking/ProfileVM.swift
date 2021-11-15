//
//  ProfileVM.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import Foundation
import Firebase


class ProfileVM : ObservableObject{
    
    func logOutCurrentUser(completion: @escaping (_ status: Bool) -> ()){
        
        do {
            try Auth.auth().signOut()
            completion(true)

        } catch {
            print("The file could not be loaded")
            completion(false)
        }
        
    
    }
    
    
}
