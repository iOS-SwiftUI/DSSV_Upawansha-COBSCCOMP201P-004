//
//  ReservedListView.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-21.
//

import SwiftUI

struct ReservedListView: View {
    
    @StateObject var vm = ReservedListVM()
    
    
    var body: some View {
        
        ZStack {
            //colorBackground
            VStack {
                CustomHeader()
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 60) {
//                            
//                            ForEach (vm.bookingsAndReservedList,id:\.slotId){ slotItem in
//                                SlotComponentHorizontal(imageString:"VIP",textString:slotItem.name)
//                                    .onTapGesture {
//                                        
//                                        vm.slotId = slotItem.slotId
//                                        vm.getSlotData(slotId: slotItem.slotId ?? "") { status in
//                                            
//                                            if status{
//                                                vm.isShowAlert = true
//                                                vm.alertTitle = "Not Available"
//                                                vm.alertMessage = "Already Booked \(vm.vehicleNo ?? "")"
//                                            }else{
//                                                
//                                                
//                                                if Auth.auth().currentUser != nil{
//                                                    
//                                                    isBookindViewIsActive.toggle()
//                                                    
//                                                }else{
//                                                    vm.isShowAlert = true
//                                                    vm.alertTitle = "Sign In"
//                                                    vm.alertMessage = "Sign in required for add bookings"
//                                                }
//                                                
//                                            }
//                                            
//                                        }
//                                        
//                                    }
//                            }
                            
                            
                        }
                        .frame(minHeight: geometry.size.height)
                        .padding(.all,20)
                    }
                    .frame(width: geometry.size.width)
                }
            }//VStack
            
            CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
            
        }//ZStack
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct ReservedListView_Previews: PreviewProvider {
    static var previews: some View {
        ReservedListView()
    }
}
