//
//  LoginView.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-14.
//

import SwiftUI

struct LoginView: View {
    
    
    @State var isForgotPasswordScreenIsActive = false
    @State var isRegisterScreenIsActive = false
    @State var isLoginSuccess = false
    
    @StateObject var vm = LoginVM()
    
    
    var body: some View {
        
        
        //  NavigationView{
        ZStack {
            //colorBackground
            VStack {
                
                //Header
                CustomHeader()
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            Spacer()
                            
                            Image("Logo")
                                .resizable()
                                .frame(width: 200, height: 100)
                            
                            
                            CustomTextField(placeHolder: "Enter email address . . .", valueText:$vm.email)
                            
                            CustomSecureTextField(placeHolder: "Enter password . . .",password:$vm.password)
                            
                            HStack{
                                Spacer()
                                
                                
                                NavigationLink(destination:
                                                ForgotPasswordView()
                                               , isActive: $isForgotPasswordScreenIsActive){
                                    
                                    Button(action: {
                                        
                                        isForgotPasswordScreenIsActive.toggle()
                                    }){
                                        Text("Forgot Password?")
                                            .foregroundColor(colorBackground)
                                            .padding(.bottom,40)
                                    }
                                }
                            }
                            
                            NavigationLink(destination:
                                            BottomTabBar()
                                           , isActive: $isLoginSuccess){
                                
                                Button(action: {
                                    
                                    if vm.proceedWithLoginView(){
                                        vm.login { success in
                                            if success{
                                                isLoginSuccess = true
                                            }
                                        }
                                    }
                                    
                                }){
                                    Text("Login")
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .frame(width: 220, height: 48)
                                        .background(colorBackground)
                                        .cornerRadius(24)
                                }                                }
                            
                            
                            
                            Spacer()
                            
                            NavigationLink(destination:
                                            SignUp()
                                           , isActive: $isRegisterScreenIsActive){
                                
                                Button(action: {
                                    
                                    isRegisterScreenIsActive.toggle()
                                }){
                                    Text("Don't you have an account? Register")
                                        .foregroundColor(colorBackground)
                                        .padding(.bottom,40)
                                }
                            }
                            
                            
                            
                        }
                        .frame(minHeight: geometry.size.height)
                        .padding(.all,20)
                    }
                    .frame(width: geometry.size.width)
                }
            }
            CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
            
        } .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        
        // }
            .accentColor(colorBackground)
        
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
