//
//  BookingView.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI
import CodeScanner


struct BookingView: View {
    
    var slotNoText:String?
    
    @StateObject var vm = BookingVM()
    
    var body: some View {
        
        ZStack {
            //colorBackground
            VStack {
                
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
                                Text(slotNoText ?? "1")
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
                            
                            
                            
                            Button(action: {}){
                                Text("Book Slot")
                                    .foregroundColor(Color.white)
                                    .frame(width: 220, height: 48)
                                    .background(colorBackground)
                                    .cornerRadius(24)
                            }
                            
                            Spacer()
                        }
                        .frame(minHeight: geometry.size.height)
                        .padding()
                        
                    }
                    .frame(width: geometry.size.width)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)

        
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
