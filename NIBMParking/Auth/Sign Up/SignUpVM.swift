//
//  SignUpVM.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-17.
//

import Foundation
import Firebase

class SignUpVM:ObservableObject{
    
    
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
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var  isBottomTabBarIsActive = false
    
    var ref: DatabaseReference! = Database.database().reference()
    
    //MARK: - VALIDATION
    func proceedWithLoginView() -> Bool {
        
        if !email.isValidEmail(){
            self.isShowAlert = true
            self.alertTitle = "Error"
            self.alertMessage = "Unformatted email adddress !"
            return false
        }
        
        else if !password.isValidPassword(){
            self.isShowAlert = true
            self.alertTitle = "Error"
            self.alertMessage = "Password should be with Minimum 8 characters at least 1 Alphabet and 1 Number:"
            return false
        }
        
        return true
        
    }
    
    
    func registerUserNetworkRequest(completion: @escaping (_ status: Bool) -> ()){
        
        Auth.auth().createUser(withEmail: email, password: password) { response, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.isShowAlert = true
                self.alertTitle = "Error"
                self.alertMessage = error?.localizedDescription ?? ""
                completion(false)
            } else {
                print("success")
                self.isShowAlert = true
                self.alertTitle = "Success"
                self.alertMessage = "Registered Successfullly!!"
                self.saveUserInDataBase(id: response?.user.uid)
                self.isBottomTabBarIsActive = true
                completion(true)
            }
        }
    }
    
    func saveUserInDataBase(id:String?){
        
        ref.child("users").child(id ?? "").setValue(["userID":id,"name":name ,"email":email ,"nic":nic ,"contactNo":contactNumber ,"registerNo":regNo,"vehicleNo":vehicleNo ,"password":password ,"confirmPassword":confirmPassword])
    }

    
}
