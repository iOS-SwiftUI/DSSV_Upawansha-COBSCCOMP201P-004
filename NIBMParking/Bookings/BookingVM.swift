//
//  BookingVM.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import Foundation
import CodeScanner
import Firebase



class BookingVM :ObservableObject{
    
    
    var ref: DatabaseReference! = Database.database().reference()

    //MARK: - PROPERTY FOR ALERT
    
    @Published var isShowAlert = false
    @Published var isCompeleted = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var isShowingScanner = false

    
    //MARK: -VIEW MODEL
    @Published  var vehicleNo: String = ""
    @Published  var regNo: String = ""
    @Published  var slotNoText:String? = "1"

    
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            print(details)
            print(result)
            slotNoText = details[0]
            guard details.count == 2 else { return }
            
            print(details)
            print(result)
            //            let person = Prospect()
            //            person.name = details[0]
            //            person.emailAddress = details[1]
            //
            //            self.prospects.people.append(person)
        case .failure(let error):
            print("Scanning failed")
        }
        
        // more code to come
    }
    
    
    func saveBoookingsInDataBase(completion: @escaping (_ status: Bool) -> ()){

        ref.child("bookings").child(slotNoText ?? "").setValue(["slotID":slotNoText,"vehicleNo":vehicleNo ,"regNo":regNo ,"createdAt":getDate()])
        completion(true)
        
    }
    
    
    
    
    func getDate()->String{
     let time = Date()
     let timeFormatter = DateFormatter()
     timeFormatter.dateFormat = "HH:ss"
     let stringDate = timeFormatter.string(from: time)
     return stringDate
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
                   
                    self.regNo = dict["registerNo"] as? String ??  ""
                    self.vehicleNo = dict["vehicleNo"] as? String ??  ""
                    
                    completion(true)

                    print(dict)
                    
                }
            }
            
        }
        
    }
    
}
