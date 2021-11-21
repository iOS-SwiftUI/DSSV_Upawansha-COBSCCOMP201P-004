//
//  ReservedListVM.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-21.
//

import Foundation


class ReservedListVM:ObservableObject{
    
    @Published var bookingsAndReservedList = [Booking]()
    
    //MARK: - PROPERTY FOR ALERT
    
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    
}
