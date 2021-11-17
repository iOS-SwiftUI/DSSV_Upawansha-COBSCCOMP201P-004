//
//  SlotModel.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-17.
//

import Foundation

struct Slot: Codable {
    
    var slotId: String?
    var name: String?
    var isVIP : String?
    var isAvailable: String?
    var bookedBy:String?


    
    
    public init(slotId:String?,name: String?,isVIP : String?,isAvailable: String?,bookedBy: String?) {
        
        self.slotId = slotId
        self.name = name
        self.isVIP = isVIP
        self.isAvailable = isAvailable
        self.bookedBy = bookedBy


        
    }
    
    public enum CodingKeys: String, CodingKey {
        case slotId = "slotId"
        case name = "name"
        case isVIP = "isVIP"
        case isAvailable = "isAvailable"
        case bookedBy = "bookedBy"


    }
    
    
}

