//
//  ProfileVM.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import Foundation
import Firebase


class ProfileVM : ObservableObject{
    
    
    //MARK: - PROPERTY FOR ALERT
    
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var nic: String = ""
    @Published var contactNumber: String = ""
    @Published var regNo: String = ""
    @Published var vehicleNo: String = ""
    
    func logOutCurrentUser(completion: @escaping (_ status: Bool) -> ()){
        
        do {
            try Auth.auth().signOut()
            completion(true)
            
        } catch {
            print("The file could not be loaded")
            completion(false)
        }
        
    }
    
    
    func getUserData(completion: @escaping (_ status: Bool) -> ()){
        
        if let user = Auth.auth().currentUser{
            
            let uid = user.uid
            let dbRef = Database.database().reference().child("users").child(uid)
            
            dbRef.observeSingleEvent(of: .value) { snapshot in
                
                if snapshot.exists(){
                    
                    guard let dict = snapshot.value as? [String: Any] else {
                        return
                    }
                    self.name = dict["name"] as? String ??  ""
                    self.email = dict["email"] as? String ??  ""
                    self.nic = dict["nic"] as? String ??  ""
                    self.contactNumber = dict["contactNo"] as? String ??  ""
                    self.regNo = dict["registerNo"] as? String ??  ""
                    self.vehicleNo = dict["vehicleNo"] as? String ??  ""
                    
                    completion(true)

                    print(dict)
                    
                }else{
                    completion(false)

                }
                
            }
            
        }
        
    }
    
    
    
    
    
    
}
