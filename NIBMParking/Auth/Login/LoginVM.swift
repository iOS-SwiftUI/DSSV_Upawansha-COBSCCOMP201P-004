//
//  LoginVM.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import Foundation
import Firebase


class LoginVM:ObservableObject{
    
    //MARK: - PROPERTY FOR ALERT
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    @Published  var email: String = ""
    @Published  var password: String = ""
    @Published var  isBottomTabBarIsActive = false

    
    
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
    
    
    //MARK: - Auth firebase request
    func login(completion: @escaping (_ status: Bool) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
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
                self.alertMessage = "Login Successfullly!!"
                self.isBottomTabBarIsActive = true
                completion(true)
            }
        }
    }
    
}



extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,3})$", options: .caseInsensitive)
        let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        print("Email validation \(valid)")
        return valid
    }
    
    func isValidPassword() -> Bool{
                let regex = try! NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$", options: .caseInsensitive)
        let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        print("Password validation \(valid)")
        return valid
    }
}
