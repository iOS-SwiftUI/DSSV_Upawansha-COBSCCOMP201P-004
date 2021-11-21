//
//  BookingVM.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import Foundation
import CodeScanner
import Firebase
import MapKit



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
    @Published  var slotNoText:String = "5"
    @Published var availabelVehicleNo:String?
    @Published var statusBooked:String?
    @Published var statusReserved:String?
    
    
    
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
            
        case .failure(let error):
            print("Scanning failed")
        }
        
        // more code to come
    }
    
    
    func reserveAndAdBookings(currentLongitude: CLLocationDegrees,currentLatitude:CLLocationDegrees,completion: @escaping (_ status: Bool) -> ()){
        
        ref.child("bookings").child(slotNoText ?? "").setValue(["slotID":slotNoText,"vehicleNo":vehicleNo ,"regNo":regNo ,"reservedTime":getDate(),"latitude":"\(currentLatitude)","longitude":"\(currentLongitude)","bookedTime":getDate(),"isReserved":"true","isBooked":"true"])
        completion(true)
        
    }
    
    func onlyReserveSlot(currentLongitude: CLLocationDegrees,currentLatitude:CLLocationDegrees,completion: @escaping (_ status: Bool) -> ()){
        
        ref.child("bookings").child(slotNoText ?? "").setValue(["slotID":slotNoText,"vehicleNo":vehicleNo ,"regNo":regNo ,"reservedTime":getDate(),"latitude":"\(currentLatitude)","longitude":"\(currentLongitude)","bookedTime":"","isReserved":"true","isBooked":""])
        completion(true)
        
    }
    
    
    func checkLocationServiceEnabled() -> Bool {
        
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus(){
                
            case .notDetermined, .restricted,.denied :
                print("No access")
                return false
            case .authorizedAlways,.authorizedWhenInUse:
                print("Access")
                return true
                
            }
        }else{
            print("Location services are not enabled")
            return false
            
        }
        
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
                        completion(false)
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
    
    
    
    func getSlotData(completion: @escaping (_ status: Bool) -> ()){
        
        let dbRef = Database.database().reference().child("bookings").child(slotNoText ?? "")
        
        dbRef.observeSingleEvent(of: .value) { snapshot in
            
            if snapshot.exists(){
                
                guard let dict = snapshot.value as? [String: Any] else {
                    completion(false)
                    return
                }
                
                self.availabelVehicleNo = dict["vehicleNo"] as? String ??  ""
                self.statusBooked = dict["isBooked"] as? String ??  ""
                self.statusReserved = dict["isReserved"] as? String ??  ""
                
                completion(true)
                
                print(dict)
                
            }
            
            completion(true)
        }
        
        
        
    }
    
}
