//
//  AboutUs.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct AboutUs: View {
    
    @State var isLoginViewIsActive = false
    
    var body: some View {
        
        ZStack {
            //colorBackground
            VStack {
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 60) {
                            
                            Spacer()
                            
                            Image("ic_about")
                                .resizable()
                                .frame(width: 300, height: 300)
                            
                            Text("Welcome to NIBM-Parking !!!")
                                .foregroundColor(colorBackground)
                                .multilineTextAlignment(.leading)
                                
                            
                            
                            NavigationLink(destination:
                                            LoginView()
                                           , isActive: $isLoginViewIsActive){
                                
                                Button(action: {
                                    
                                    isLoginViewIsActive = true
                                }){
                                    Text("Continue as login")
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .frame(width: 220, height: 48)
                                        .background(colorBackground)
                                        .cornerRadius(24)
                                }
                            }
                            
                            
                            
                            
                            Spacer()
                            
                        }
                        .frame(minHeight: geometry.size.height)
                        .padding(.all,20)
                    }
                    .frame(width: geometry.size.width)
                }
            }
            
            
        }//ZStck
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)

    }
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}
