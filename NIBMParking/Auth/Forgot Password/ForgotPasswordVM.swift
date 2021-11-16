//
//  ForgotPasswordVM.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-17.
//

import Foundation
import Firebase

class ForgotPasswordVM:ObservableObject{
    
    //MARK: - PROPERTY FOR ALERT
    
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    @Published  var email: String = ""
    
    
    //MARK: - VALIDATION
    func proceedWithLoginView() -> Bool {
        
        if !email.isValidEmail(){
            self.isShowAlert = true
            self.alertTitle = "Error"
            self.alertMessage = "Unformatted email adddress !"
            return false
        }
        
        return true
        
    }
    
    
    func resetPassword(completion: @escaping (_ status: Bool) -> ()){
        Auth.auth().sendPasswordReset(withEmail: email) { error  in
            
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
                self.alertMessage = "Reset email sent !!"
                completion(true)
                //save local user
            }
        }
    }
    
}

