import SwiftUI

struct SignUp: View {
    
    
    @StateObject var vm = SignUpVM()
    @State var isSignUpSuccess = false

    
    
    var body: some View {
        
        ZStack {
            //colorBackground
            VStack {
                
                CustomHeader(headerTitle: "Sign Up")
                
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            Image("Logo")
                                .resizable()
                                .frame(width: 200, height: 100)
                            
                            
                            CustomTextField(placeHolder: "Enter name . . .", valueText: $vm.name)
                            CustomTextField(placeHolder: "Enter email address . . .", valueText: $vm.email)
                            CustomTextField(placeHolder: "Enter phone number . . .", valueText: $vm.contactNumber)
                            CustomTextField(placeHolder: "Enter NIC number . . .", valueText: $vm.nic)
                            CustomTextField(placeHolder: "Enter registration number . . .", valueText: $vm.regNo)
                            CustomTextField(placeHolder: "Enter vehicle number . . .", valueText: $vm.vehicleNo)
                            CustomSecureTextField(placeHolder: "Enter password . . .",password: $vm.password)
                            CustomSecureTextField(placeHolder: "Enter confirm password . . .",password: $vm.confirmPassword)
                            
                            
                            NavigationLink(destination:
                                            BottomTabBar()
                                           , isActive: $isSignUpSuccess){
                                
                                Button(action: {
                                    
                                    if vm.proceedWithLoginView(){
                                        vm.registerUserNetworkRequest { success in
                                            if success{
                                                isSignUpSuccess = true
                                            }
                                        }
                                    }
                                    
                                }){
                                    Text("Sign Up")
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .frame(width: 220, height: 48)
                                        .background(colorBackground)
                                        .cornerRadius(24)
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
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
        
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

