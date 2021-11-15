//
//  ProfileView.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var nic: String = ""
    @State private var contactNumber: String = ""
    @State private var regNo: String = ""
    @State private var vehicleNo: String = ""
    
    
    
    var body: some View {
        
        ZStack {
            //colorBackground
            VStack {
                
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            Spacer()
                            
                            CustomLabelAndNotEditableTextField(labelTxt:"Name", valueText: $name)
                            CustomLabelAndNotEditableTextField(labelTxt:"Email", valueText: $email)
                            CustomLabelAndNotEditableTextField(labelTxt:"NIC", valueText: $nic)
                            CustomLabelAndNotEditableTextField(labelTxt:"Contact Number", valueText: $contactNumber)
                            CustomLabelAndNotEditableTextField(labelTxt:"Register Number", valueText: $regNo)
                            CustomLabelAndNotEditableTextField(labelTxt:"Vehicle Number", valueText: $vehicleNo)
                         
                            Spacer()
                            
                            Button(action: {}){
                                Text("Log Out")
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(width: 220, height: 48)
                                    .background(colorBackground)
                                    .cornerRadius(24)
                            }
                            .padding(.bottom,40)
                        }
                        .frame(minHeight: geometry.size.height)
                        .padding(.all,20)

                        
                    }
                    .frame(width: geometry.size.width)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
