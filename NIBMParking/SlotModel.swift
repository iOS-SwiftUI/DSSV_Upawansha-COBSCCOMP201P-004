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


    
    
    public init(slotId:String?,name: String?,isVIP : String?) {
        
        self.slotId = slotId
        self.name = name
        self.isVIP = isVIP



        
    }
    
    public enum CodingKeys: String, CodingKey {
        case slotId = "slotId"
        case name = "name"
        case isVIP = "isVIP"



    }
    
    
}

