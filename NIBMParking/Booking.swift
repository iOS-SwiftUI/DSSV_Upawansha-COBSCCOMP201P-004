//
//  Booking.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-17.
//

import Foundation


struct Booking: Codable {
    
    var slotId: String?
    var vehicleNo: String?
    var regNo : String?
    var createdAt: String?

 
    public init(slotId:String?,vehicleNo: String?,regNo : String?,createdAt: String?) {
        
        self.slotId = slotId
        self.vehicleNo = vehicleNo
        self.regNo = regNo
        self.createdAt = createdAt

    }
    
    public enum CodingKeys: String, CodingKey {
        case slotId = "slotId"
        case vehicleNo = "vehicleNo"
        case regNo = "regNo"
        case createdAt = "createdAt"
        
    }
    
    
}
