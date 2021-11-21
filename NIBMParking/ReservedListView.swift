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
                            
                            HStack{
                                
                                Text("Vehicle Number : ")
                                    .foregroundColor(colorBackground)
                                
                                Text(vehicleNo)
                                    .foregroundColor(colorBackground)
                            }
                            
                            
                            ForEach (vm.bookingsAndReservedList,id:\.slotId){ slotItem in
                                
                                VStack{
                                    HStack{
                                        Text("Slot No.\(slotItem.slotId ?? "N/A")")
                                            .padding()
                                        Spacer()
                                        
                                        Spacer()
                                        if slotItem.isBooked != "false" && slotItem.isBooked != ""{
                                            Text("Status: Booked")
                                                .padding()
                                            
                                            
                                        }else{
                                            Text("Status: Reserved")
                                                .padding()
                                            
                                            
                                        }
                                        
                                    }//HStack
                                    .padding()
                                    
                                    
                                    if slotItem.isBooked != "false" && slotItem.isBooked != ""{
                                        
                                        HStack{
                                            Spacer()
                                            Button(action: {
                                                
                                            }){
                                                Text("End")
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 150, height: 48)
                                                    .background(colorBackground)
                                                    .cornerRadius(24)
                                            }
                                            Button(action: {
                                                
                                          
                                                vm.deleteRecordBookings(slotId: slotItem.slotId ?? "")
                                                
                                            }){
                                                Text("Cancel")
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 150, height: 48)
                                                    .background(Color.red)
                                                    .cornerRadius(24)
                                            }
                                            
                                        }
                                        .padding()
                                        
                                    }else{
                                        
                                        
                                        HStack{
                                            
                                            Spacer()
                                        
                                            
                                            Button(action: {
                                                
                                            }){
                                                Text("Book")
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 150, height: 48)
                                                    .background(colorBackground)
                                                    .cornerRadius(24)
                                            }
                                            
                                            
                                            Button(action: {
                                                
                                            }){
                                                Text("Cancel")
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .frame(width: 150, height: 48)
                                                    .background(Color.red)
                                                    .cornerRadius(24)
                                            }
                                        }
                                        .padding()
                                        
                                        
                                    }
                                    
                                    
                                    
                                }//VStack
                                .background(cardColor)
                                .cornerRadius(20)

                                
                                
                            }
                            
                            Spacer()
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
