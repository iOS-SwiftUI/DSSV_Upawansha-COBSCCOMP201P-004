//
//  HomeView.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI
import RappleProgressHUD
import Firebase


struct HomeView: View {
    
    @State private var isShowingNumber: Int = 0
    
    @State var isBookindViewIsActive = false
    
    @StateObject var vm = HomeVM()
    
    var body: some View {
        
        NavigationView{
            ZStack {
                //colorBackground
                VStack {
                    GeometryReader { geometry in
                        
                        ScrollView(.vertical , showsIndicators: false) {
                            
                            VStack(alignment: .leading, spacing: 20) {
                                
                                Text("VIP Slots")
                                    .foregroundColor(Color.gray)
                                    .font(.largeTitle)
                                
                                
                                NavigationLink(destination:
                                                BookingView(slotNo: vm.slotId,navigateFrom: true)
                                               , isActive: $isBookindViewIsActive){
                                    
                                    VStack{
                                        ForEach (vm.vipSlotList,id:\.slotId){ slotItem in
                                            SlotComponentHorizontal(imageString:"VIP",textString:slotItem.name)
                                                .onTapGesture {
                                                
                                                    vm.slotId = slotItem.slotId
                                                    vm.getSlotData(slotId: slotItem.slotId ?? "") { status in
                                                        
                                                        if status{
                                                            
                                                            if vm.isBooked != "" && vm.isBooked != "false" {
                                                                
                                                                vm.isShowAlert = true
                                                                vm.alertTitle = "Not Available"
                                                                vm.alertMessage = "Already Booked \(vm.vehicleNo ?? "")"
                                                                
                                                            }else {
                                                                
                                                                vm.isShowAlert = true
                                                                vm.alertTitle = "Not Available"
                                                                vm.alertMessage = "Already Reserved \(vm.vehicleNo ?? "")"
                                                            }
                                                            
                                                            
                                                        }else{
                                                            
                                                
                                                            if Auth.auth().currentUser != nil{
                                                                
                                                                isBookindViewIsActive.toggle()

                                                            }else{
                                                                vm.isShowAlert = true
                                                                vm.alertTitle = "Sign In"
                                                                vm.alertMessage = "Sign in required for add bookings"
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                        }
                                    }
                                }
                                
                                
                                Text("Normal Slots")
                                    .foregroundColor(Color.gray)
                                    .font(.largeTitle)
                                
                                NavigationLink(destination:
                                                BookingView(slotNo: vm.slotId,navigateFrom: true)
                                               , isActive: $isBookindViewIsActive){
                                    
                                    VStack{
                                        ForEach (vm.normalSlotList,id:\.slotId){ slotItem in
                                            SlotComponentHorizontal(imageString:"Normal",textString:slotItem.name)
                                                .onTapGesture {
                                                    vm.slotId = slotItem.slotId
                                                    
                                                    vm.getSlotData(slotId: slotItem.slotId ?? "") { status in
                                                        
                                                        if status{
                                                            vm.isShowAlert = true
                                                            vm.alertTitle = "Not Available"
                                                            vm.alertMessage = "Already Booked \(vm.vehicleNo ?? "")"
                                                        }else{
                                                            
                                                            if Auth.auth().currentUser != nil{
                                                                
                                                                isBookindViewIsActive.toggle()

                                                            }else{
                                                                vm.isShowAlert = true
                                                                vm.alertTitle = "Sign In"
                                                                vm.alertMessage = "Sign in required for add bookings"
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                }
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            .frame(minHeight: geometry.size.height)
                            .padding(.top,20)
                            .padding(.leading,20)
                        }
                        .frame(width: geometry.size.width)
                    }
                }//VStack
                
                .navigationBarHidden(true)
                .navigationTitle("")
                
                CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
            }//Zstack
            .onAppear{
                RappleActivityIndicatorView.startAnimating()
                vm.fetchSlots { status in
                    RappleActivityIndicatorView.stopAnimation()
                    
                    if status{
                        print("success  !!!!")
                        print(vm.vipSlotList)
                        print(vm.normalSlotList)
                    }
                }
            }
            
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
