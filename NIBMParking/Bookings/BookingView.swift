//
//  BookingView.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI
import CodeScanner
import RappleProgressHUD
import MapKit


struct BookingView: View {
    
    @ObservedObject private var locationManager = LocationManager()
    @StateObject var vm = BookingVM()
    @State  var slotNo:String?
    @State var navigateFrom = false
    @State var isBookindListViewIsActive = false

    
    var body: some View {
        
        let coordinate = self.locationManager.location != nil ? self.locationManager.location?.coordinate : CLLocationCoordinate2D()
        
        
        ZStack {
            //colorBackground
            VStack {
                
                if navigateFrom == false{
                    
                }else{
                    CustomHeader()
                }
                
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            HStack(spacing:20){
                                
                                CustomLabelAndNotEditableTextField(labelTxt: "Vehicle No.", valueText: $vm.vehicleNo)
                                CustomLabelAndNotEditableTextField(labelTxt: "Register No.", valueText: $vm.regNo)
                                
                            }.padding(.top,60)
                            
                            Spacer()
                            
                            
                            HStack{
                                Spacer()
                                Text("Slot No.")
                                    .font(.largeTitle)
                                Text(vm.slotNoText ?? "")
                                    .font(.largeTitle)
                                Spacer()
                            }
                            
                            Button(action: {
                                vm.isShowingScanner = true
                                
                            }){
                                
                                VStack{
                                    
                                    Image("Qr_Code")
                                        .resizable()
                                        .frame(width: 150, height: 120)
                                    Text("Tap to scan the QR Code")
                                        .foregroundColor(colorBackground)
                                    
                                }
                            }
                            
                            
                            Button(action: {
                                
                                let access = vm.checkLocationServiceEnabled()
                                
                                if access == true{
                                    
                                    RappleActivityIndicatorView.startAnimating()
                                    if vm.slotNoText != ""{
                                        vm.getSlotData { status in
                                            RappleActivityIndicatorView.stopAnimation()
                                            if status{
                                                if vm.availabelVehicleNo == nil{
                                                    RappleActivityIndicatorView.startAnimating()
                                                    
                                                    guard let longitude = coordinate?.longitude else{
                                                        self.locationManager.location?.coordinate
                                                        return
                                                    }
                                                    
                                                    guard let latitude = coordinate?.latitude else{
                                                        self.locationManager.location?.coordinate
                                                        return
                                                    }
                                                    
                                                    let coordinate0 = CLLocation(latitude: latitude, longitude: longitude)
                                                    let coordinate1 = CLLocation(latitude: 6.9027724, longitude: 79.8686713)
                                                    
                                                    let distanceInMeters = coordinate0.distance(from: coordinate1)
                                                    let distanceInKilometers = distanceInMeters/1000
                                                    
                                                    print(distanceInMeters)// result is in meters
                                                    
                                                    if distanceInKilometers < 1 {
                                                        vm.onlyReserveSlot(currentLongitude: longitude,currentLatitude:latitude) { success in
                                                            RappleActivityIndicatorView.stopAnimation()
                                                            if success{
                                                                vm.isShowAlert = true
                                                                vm.alertTitle = "Success"
                                                                vm.alertMessage = "Reserved Succesfully !!"
                                                            }else{
                                                                vm.isShowAlert = true
                                                                vm.alertTitle = "Error"
                                                                vm.alertMessage = "Reserved failed !"
                                                            }
                                                        }
                                                    }else{
                                                        RappleActivityIndicatorView.stopAnimation()
                                                        vm.isShowAlert = true
                                                        vm.alertTitle = "Error"
                                                        vm.alertMessage = "You are far from the NIBM parking"
                                                    }
                                                    
                                                }else{
                                                    
                                                    if vm.statusBooked != "false" && vm.statusBooked != ""{
                                                        vm.isShowAlert = true
                                                        vm.alertTitle = "Not Available"
                                                        vm.alertMessage = "Already booked \(vm.availabelVehicleNo ?? "")"
                                                    }else{
                                                        vm.isShowAlert = true
                                                        vm.alertTitle = "Not Available"
                                                        vm.alertMessage = "Already Reserved \(vm.availabelVehicleNo ?? "")"
                                                    }
                                                    
                                                }
                                                
                                            }else{
                                                print("Error !!!")
                                            }
                                        }
                                    }else{
                                        
                                        vm.isShowAlert = true
                                        vm.alertTitle = "Error"
                                        vm.alertMessage = "Slot No Required"
                                    }
                                    
                                    
                                }else{
                                    vm.isShowAlert = true
                                    vm.alertTitle = "Location"
                                    vm.alertMessage = "Please enable location services before add booking"
                                }
                                
                                
                                
                            }){
                                Text("Reserve Slot")
                                    .foregroundColor(Color.white)
                                    .frame(width: 220, height: 48)
                                    .background(colorBackground)
                                    .cornerRadius(24)
                            }
                            
                            
                            Button(action: {
                                
                                
                                let access = vm.checkLocationServiceEnabled()
                                
                                if access == true{
                                    
                                    RappleActivityIndicatorView.startAnimating()
                                    if vm.slotNoText != ""{
                                        vm.getSlotData { status in
                                            RappleActivityIndicatorView.stopAnimation()
                                            if status{
                                                if vm.availabelVehicleNo == nil{
                                                    RappleActivityIndicatorView.startAnimating()
                                                    
                                                    guard let longitude = coordinate?.longitude else{
                                                        self.locationManager.location?.coordinate
                                                        return
                                                    }
                                                    
                                                    guard let latitude = coordinate?.latitude else{
                                                        self.locationManager.location?.coordinate
                                                        return
                                                    }
                                                    
                                                    let coordinate0 = CLLocation(latitude: latitude, longitude: longitude)
                                                    let coordinate1 = CLLocation(latitude: 6.9027724, longitude: 79.8686713)
                                                    
                                                    let distanceInMeters = coordinate0.distance(from: coordinate1)
                                                    let distanceInKilometers = distanceInMeters/1000
                                                    
                                                    print(distanceInMeters)// result is in meters
                                                    
                                                    if distanceInKilometers < 1 {
                                                        vm.reserveAndAdBookings(currentLongitude: longitude,currentLatitude:latitude) { success in
                                                            RappleActivityIndicatorView.stopAnimation()
                                                            if success{
                                                                vm.isShowAlert = true
                                                                vm.alertTitle = "Success"
                                                                vm.alertMessage = "Booked Succesfully !!"
                                                            }else{
                                                                vm.isShowAlert = true
                                                                vm.alertTitle = "Error"
                                                                vm.alertMessage = "Booked failed !"
                                                            }
                                                        }
                                                    }else{
                                                        RappleActivityIndicatorView.stopAnimation()
                                                        vm.isShowAlert = true
                                                        vm.alertTitle = "Error"
                                                        vm.alertMessage = "You are far from the NIBM parking"
                                                    }
                                                    
                                                }else{
                                                    
                                                    if vm.statusBooked != "false" && vm.statusBooked != ""{
                                                        vm.isShowAlert = true
                                                        vm.alertTitle = "Not Available"
                                                        vm.alertMessage = "Already booked \(vm.availabelVehicleNo ?? "")"
                                                    }else{
                                                        vm.isShowAlert = true
                                                        vm.alertTitle = "Not Available"
                                                        vm.alertMessage = "Already Reserved \(vm.availabelVehicleNo ?? "")"
                                                    }
                                                }
                                                
                                            }else{
                                                print("Error !!!")
                                            }
                                        }
                                    }else{
                                        
                                        vm.isShowAlert = true
                                        vm.alertTitle = "Error"
                                        vm.alertMessage = "Slot No Required"
                                    }
                                    
                                    
                                }else{
                                    vm.isShowAlert = true
                                    vm.alertTitle = "Location"
                                    vm.alertMessage = "Please enable location services before add booking"
                                }
                                
                            }){
                                Text("Reserve and Book")
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(width: 220, height: 48)
                                    .background(colorBackground)
                                    .cornerRadius(24)
                            }
                            
                            
                            NavigationLink(destination:ReservedListView(vehicleNo:vm.vehicleNo), isActive: $isBookindListViewIsActive){
                                Button(action: {
                                    isBookindListViewIsActive.toggle()

                                }){
                                    Text("View Reserved and Booked List")
                                        .foregroundColor(Color.white)
                                        .padding()
                                    // .frame(width: 220, height: 48)
                                        .background(colorBackground)
                                        .cornerRadius(24)
                                        .lineLimit(2)
                                }
                            }
                            
                            Spacer()
                        }
                        .frame(minHeight: geometry.size.height)
                        .padding()
                        
                    }
                    .frame(width: geometry.size.width)
                }
                
                
            }//Vstack
            .navigationBarHidden(true)
            .navigationTitle("")
            .onAppear{
                RappleActivityIndicatorView.startAnimating()
                vm.getUserData { status in
                    RappleActivityIndicatorView.stopAnimation()
                }
                
                vm.slotNoText = slotNo ?? ""
            }
            
            CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
            
            
        }//ZStack
        
        .edgesIgnoringSafeArea(.all)
        
        
        
        .sheet(isPresented: $vm.isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul hudson\npaul@hackingwithswift.com", completion: vm.handleScan)
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
