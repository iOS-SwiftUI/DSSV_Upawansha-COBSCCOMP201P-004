//
//  HomeVM.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-17.
//

import Foundation
import Firebase

class HomeVM:ObservableObject{
    
    //MARK: - PROPERTY FOR ALERT
    
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    @Published var normalSlotList = [Slot]()
    @Published var vipSlotList = [Slot]()
    
    @Published var vehicleNo:String?
    
    func fetchSlots(completion: @escaping (_ status: Bool) -> ()){
        
        let slotListRef: DatabaseReference! = Database.database().reference().child("slots")
        
        slotListRef.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0{
                self.normalSlotList.removeAll()
                self.vipSlotList.removeAll()
                
                for slots in snapshot.children.allObjects as! [DataSnapshot]{
                    
                    let slotObject = slots.value as? [String: AnyObject]
                    
                    let slotId = slotObject?["slotId"]
                    let name  = slotObject?["name"]
                    let isVIP = slotObject?["isVIP"]
                    let bookedBy  = slotObject?["bookedBy"]
   
                    
                    let slot = Slot(slotId: slotId as! String?, name: name as! String?, isVIP: isVIP as! String?)
                    //appending it to list
                    
                    if slot.isVIP == "false"{
                        self.normalSlotList.append(slot)
                    }else if slot.isVIP == "true" {
                        self.vipSlotList.append(slot)
                    }
                    
                }
                
                completion(true)
            }
        }
    }
    
    
    
    
    func getSlotData(slotId:String,completion: @escaping (_ status: Bool) -> ()){
        
            
            let dbRef = Database.database().reference().child("bookings").child(slotId)
            
            dbRef.observeSingleEvent(of: .value) { snapshot in
                
                if snapshot.exists(){
                    
                    guard let dict = snapshot.value as? [String: Any] else {
                        completion(false)
                        return
                    }
                    
                    self.vehicleNo = dict["vehicleNo"] as? String ??  ""
                    
                    completion(true)

                    print(dict)
                    
                }
            }
            
        
        
    }
}
