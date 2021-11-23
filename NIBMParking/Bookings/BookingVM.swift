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
    
    
    @Published var longitude:Double?
    @Published var latitude:Double?
    
    
    
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            print(details)
            print(result)
            self.dataClean()
            slotNoText = details[0]
            guard details.count == 2 else { return }
            
            print(details)
            print(result)
            
        case .failure(let error):
            print("Scanning failed")
        }
        
        // more code to come
    }
    
    
    func dataClean(){
        availabelVehicleNo = ""
    }
    
    func reserveAndAdBookings(completion: @escaping (_ status: Bool) -> ()){
        
        ref.child("bookings").child(slotNoText ).setValue(["slotID":slotNoText,"vehicleNo":vehicleNo ,"regNo":regNo ,"reservedTime":getDate(),"reservedLocationLatitude":"\(latitude)","reservedLocationLongitude":"\(longitude)","bookedTime":getDate(),"isReserved":"true","isBooked":"true"])
        self.isShowAlert = true
        self.alertTitle = "Success !!!"
        self.alertMessage = "Successfully Booked !!!"
        completion(true)
        
    }
    
    func onlyReserveSlot(completion: @escaping (_ status: Bool) -> ()){
        
        ref.child("bookings").child(slotNoText ).setValue(["slotID":slotNoText,"vehicleNo":vehicleNo ,"regNo":regNo ,"reservedTime":getDate(),"reservedLocationLatitude":"\(latitude)","reservedLocationLongitude":"\(longitude)","bookedTime":"","isReserved":"true","isBooked":""])
        
        self.isShowAlert = true
        self.alertTitle = "Success !!!"
        self.alertMessage = "Successfully Reserved !!!"
        
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
                        completion(false)
                        return
                    }
                    
                    self.regNo = dict["registerNo"] as? String ??  ""
                    self.vehicleNo = dict["vehicleNo"] as? String ??  ""
                    
                    completion(true)
                    
                    print(dict)
                    
                }else{
                    completion(true)
                    
                }
            }
            
        }
        
    }
    
    
    
    func checkSlotBookedOrReserved(completion: @escaping (_ status: Bool) -> ()){
        
        let dbRef = Database.database().reference().child("bookings").child(slotNoText)
        
        dbRef.observeSingleEvent(of: .value) { snapshot in
            
            if snapshot.exists(){
                
                guard let dict = snapshot.value as? [String: Any] else {
                    completion(false)
                    return
                }
                
                self.availabelVehicleNo = dict["vehicleNo"] as? String ??  ""
                self.statusBooked = dict["isBooked"] as? String ??  ""
                self.statusReserved = dict["isReserved"] as? String ??  ""
                
                if self.statusBooked != "false" && self.statusBooked != ""{
                    self.isShowAlert = true
                    self.alertTitle = "Not Available"
                    self.alertMessage = "Already booked \(self.availabelVehicleNo ?? "")"
                }else{
                    self.isShowAlert = true
                    self.alertTitle = "Not Available"
                    self.alertMessage = "Already Reserved \(self.availabelVehicleNo ?? "")"
                }
                
                completion(false)
                
                print(dict)
                
            }else{
                
                self.availabelVehicleNo = ""
                self.statusBooked = ""
                self.statusReserved = ""
                completion(true)
                
            }
            
        }
    }
    
    
    func checkSlotNumberAvilability(completion: @escaping (_ status: Bool) -> ()){
        
        if slotNoText != ""{
            completion(true)
            
        }else{
            
            isShowAlert = true
            alertTitle = "Error"
            alertMessage = "Slot No Required"
            completion(false)
        }
    }
    
    func checkLocationAccess(completion: @escaping (_ status: Bool) -> ()){
        
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus(){
                
            case .notDetermined, .restricted,.denied :
                isShowAlert = true
                alertTitle = "Location"
                alertMessage = "Please enable location services before add booking"
                completion(false)
            case .authorizedAlways,.authorizedWhenInUse:
                print("Access")
                completion(true)
                
            }
        }else{
            isShowAlert = true
            alertTitle = "Location"
            alertMessage = "Please enable location services before add booking"
            completion(false)
            
        }
    }
    
    
    func checkDistancetoPoint(completion: @escaping (_ status: Bool) -> ()){
        
        guard let latitudeLocation = latitude else{
            isShowAlert = true
            alertTitle = "Location"
            alertMessage = "Please enable location services before add booking"
            completion(false)
            return
        }
        
        guard let longitudeLocation = longitude else{
            isShowAlert = true
            alertTitle = "Location"
            alertMessage = "Please enable location services before add booking"
            completion(false)
            return
        }
        
        let coordinate0 = CLLocation(latitude: latitudeLocation, longitude: longitudeLocation)
        let coordinate1 = CLLocation(latitude: 6.9027724, longitude: 79.8686713)
        
        let distanceInMeters = coordinate0.distance(from: coordinate1)
        let distanceInKilometers = distanceInMeters/1000
        
        if distanceInKilometers < 1 {
            completion(true)
            
        }else{
            
            isShowAlert = true
            alertTitle = "Error"
            alertMessage = "You are far from the NIBM parking"
            completion(false)
        }
    }
}
