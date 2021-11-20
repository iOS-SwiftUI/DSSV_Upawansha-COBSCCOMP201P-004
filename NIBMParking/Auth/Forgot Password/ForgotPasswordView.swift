//
//  ForgotPasswordView.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-14.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @StateObject var vm = ForgotPasswordVM()
    
    var body: some View {
        
        ZStack {
            //colorBackground
            VStack {
                CustomHeader()
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 60) {
                            
                            Spacer()
                            
                            Image("Logo")
                                .resizable()
                                .frame(width: 200, height: 100)
                            
                            CustomTextField(placeHolder: "Enter email address . . .", valueText: $vm.email)
                            
                            Button(action: {
                                
                                vm.resetPassword { status in
                                    if status{
                                        vm.email = ""
                                    }
                                }
                                
                            }){
                                Text("Submit")
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(width: 220, height: 48)
                                    .background(colorBackground)
                                    .cornerRadius(24)
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
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)

        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
