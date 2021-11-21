//
//  Booking.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-17.
//

import Foundation


struct Booking: Codable {
    
    var slotId: String?
    var regNo : String?
    var vehicleNo:String?
    var reservedLocationLongitude:String?
    var reservedLocationLatitude:String?
    var reservedTime: String?
    var bookedTime:String?
    var isReserved:String?
    var isBooked:String?
    
    
    public init(slotId:String?,regNo: String?,reservedLocationLongitude : String?,reservedLocationLatitude : String?,reservedTime: String?,bookedTime: String?,vehicleNo: String?,isBooked: String?) {
        
        self.slotId = slotId
        self.regNo = regNo
        self.reservedLocationLongitude = reservedLocationLongitude
        self.reservedLocationLatitude = reservedLocationLatitude
        self.reservedTime = reservedTime
        self.bookedTime = bookedTime
        self.vehicleNo = vehicleNo
        self.isBooked = isBooked
        
    }
    
    public enum CodingKeys: String, CodingKey {
        
        case slotId = "slotId"
        case regNo = "regNo"
        case reservedLocationLongitude = "reservedLocationLongitude"
        case reservedLocationLatitude = "reservedLocationLatitude"
        case reservedTime = "reservedTime"
        case bookedTime = "bookedTime"
        case vehicleNo = "vehicleNo"
        case isBooked = "isBooked"
        
    }
    
    
}
