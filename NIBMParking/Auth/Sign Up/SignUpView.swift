import SwiftUI

struct SignUp: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var nic: String = ""
    @State private var contactNumber: String = ""
    @State private var regNo: String = ""
    @State private var vehicleNo: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    
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
                            
                            
                            CustomTextField(placeHolder: "Enter name . . .", valueText: $name)
                            CustomTextField(placeHolder: "Enter email address . . .", valueText: $email)
                            CustomTextField(placeHolder: "Enter NIC number . . .", valueText: $nic)
                            CustomTextField(placeHolder: "Enter registration number . . .", valueText: $regNo)
                            CustomTextField(placeHolder: "Enter vehicle number . . .", valueText: $vehicleNo)
                            CustomSecureTextField(placeHolder: "Enter password . . .",password: $password)
                            CustomSecureTextField(placeHolder: "Enter confirm password . . .",password: $confirmPassword)
                            
                            
                            Button(action: {}){
                                Text("Sign Up")
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(width: 220, height: 48)
                                    .background(colorBackground)
                                    .cornerRadius(24)
                            }
                            
                        }
                        .frame(minHeight: geometry.size.height)
                        .padding(.all,20)
                    }
                    .frame(width: geometry.size.width)
                }
            }
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

