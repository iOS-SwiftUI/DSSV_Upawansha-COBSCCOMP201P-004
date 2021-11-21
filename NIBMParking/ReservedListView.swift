//
//  ReservedListView.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-21.
//

import SwiftUI
import RappleProgressHUD

struct ReservedListView: View {
    
    @StateObject var vm = ReservedListVM()
    @State  var vehicleNo: String = ""
    
    
    var body: some View {
        
        ZStack {
            //colorBackground
            VStack {
                CustomHeader()
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 60) {
                            
                            Text(vehicleNo)
                                .font(.largeTitle)
                                .foregroundColor(colorBackground)
                            
                            ForEach (vm.bookingsAndReservedList,id:\.slotId){ slotItem in
                                
                                VStack(spacing:10){
                               
                                    HStack{
                                        Text("Slot No.\(slotItem.slotId ?? "N/A")")
                                        Spacer()
                                        
                                        Spacer()
                                        if slotItem.isBooked != "false" && slotItem.isBooked != ""{
                                            Text("Booked")
                                        }else{
                                            Text("Reserved")
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                
                            }
                            
                            
                        }
                        .frame(minHeight: geometry.size.height)
                        .padding(.all,20)
                    }
                    .frame(width: geometry.size.width)
                }
            }//VStack
            
            CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
            
        }//ZStack
        .onAppear{
            
            RappleActivityIndicatorView.startAnimating()
            vm.getSlotData(vehicleNoString: vehicleNo) { success in
                RappleActivityIndicatorView.stopAnimation()
                
                print("")
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        
        
    }
}

struct ReservedListView_Previews: PreviewProvider {
    static var previews: some View {
        ReservedListView()
    }
}
