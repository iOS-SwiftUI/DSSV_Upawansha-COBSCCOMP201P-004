//
//  BookingView.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct BookingView: View {
    
    var slotNoText:String?
    
    var body: some View {
        
        ZStack {
            //colorBackground
            VStack {
                
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            Spacer()
                            
                            HStack{
                                Spacer()
                                Text("Slot No.")
                                    .font(.largeTitle)
                                Text(slotNoText ?? "1")
                                    .font(.largeTitle)
                                Spacer()
                            }
                            
                            Button(action: {}){
                                
                                VStack{
                                    
                                    Image("Qr_Code")
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                    Text("Tap to scan the QR Code")
                                        .foregroundColor(colorBackground)
                                    
                                    
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {}){
                                Text("Book Slot")
                                    .foregroundColor(Color.white)
                                    .frame(width: 220, height: 48)
                                    .background(colorBackground)
                                    .cornerRadius(24)
                            }.padding(.bottom,40)
                            
                           
                            
                        }
                        .frame(minHeight: geometry.size.height)
                        
                    }
                    .frame(width: geometry.size.width)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
