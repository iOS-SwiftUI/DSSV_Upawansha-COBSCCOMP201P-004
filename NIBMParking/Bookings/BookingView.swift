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
                                Text(vm.slotNoText )
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
                                RappleActivityIndicatorView.startAnimating()
                                
                                vm.checkLocationAccess { success in
                                    
                                    if success{
                                        vm.checkSlotNumberAvilability { success in
                                            if success{
                                                
                                                vm.latitude = coordinate?.latitude
                                                vm.longitude = coordinate?.longitude
                                                
                                                vm.checkDistancetoPoint { success in
                                                    if success{
                                                        vm.checkSlotBookedOrReserved {  success in
                                                            if success{
                                                                vm.onlyReserveSlot { success in
                                                                    if success{
                                                                        RappleActivityIndicatorView.stopAnimation()
                                                                        print("reserved")
                                                                    }else{
                                                                        RappleActivityIndicatorView.stopAnimation()
                                                                        
                                                                    }
                                                                }
                                                            }else{
                                                                RappleActivityIndicatorView.stopAnimation()
                                                                
                                                            }
                                                        }
                                                    }else{
                                                        RappleActivityIndicatorView.stopAnimation()
                                                    }
                                                }
                                            }else{
                                                RappleActivityIndicatorView.stopAnimation()
                                            }
                                        }
                                    }else{
                                        RappleActivityIndicatorView.stopAnimation()
                                    }
                                }
                                
                            }){
                                Text("Reserve Slot")
                                    .foregroundColor(Color.white)
                                    .frame(width: 220, height: 48)
                                    .background(colorBackground)
                                    .cornerRadius(24)
                            }
                            
                            
                            Button(action: {
                                RappleActivityIndicatorView.startAnimating()
                                
                                vm.checkLocationAccess { success in
                                    
                                    if success{
                                        vm.checkSlotNumberAvilability { success in
                                            if success{
                                                
                                                vm.latitude = coordinate?.latitude
                                                vm.longitude = coordinate?.longitude
                                                
                                                vm.checkDistancetoPoint { success in
                                                    if success{
                                                        vm.checkSlotBookedOrReserved {  success in
                                                            if success{
                                                                vm.reserveAndAdBookings { success in
                                                                    if success{
                                                                        RappleActivityIndicatorView.stopAnimation()
                                                                        print("reserved")
                                                                    }else{
                                                                        RappleActivityIndicatorView.stopAnimation()
                                                                        
                                                                    }
                                                                }
                                                            }else{
                                                                RappleActivityIndicatorView.stopAnimation()
                                                                
                                                            }
                                                        }
                                                    }else{
                                                        RappleActivityIndicatorView.stopAnimation()
                                                    }
                                                }
                                            }else{
                                                RappleActivityIndicatorView.stopAnimation()
                                            }
                                        }
                                    }else{
                                        RappleActivityIndicatorView.stopAnimation()
                                    }
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
