//
//  BookingVM.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import Foundation
import CodeScanner



class BookingVM :ObservableObject{
    
    //MARK: - PROPERTY FOR ALERT
    
    @Published var isShowAlert = false
    @Published var isCompeleted = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var isShowingScanner = false

    
    //MARK: -VIEW MODEL
    @Published  var vehicleNo: String = ""
    @Published  var regNo: String = ""
    
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            print(details)
            print(result)
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
    
}
