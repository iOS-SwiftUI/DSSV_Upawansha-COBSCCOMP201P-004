//
//  CustomSecureTextField.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct CustomSecureTextField: View {
    
    @State  var showPassword: Bool = false
    var placeHolder:String
    @Binding  var password:String
    
    
    var body: some View {
        HStack {
            if showPassword {
                TextField(placeHolder, text: $password)
            } else {
                SecureField(placeHolder, text: $password)
            }
            Button(action: {
                showPassword.toggle()
            }) {
                Image(systemName: self.showPassword ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }.padding()
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(colorBackground, style: StrokeStyle(lineWidth: 1.0)))
    }
}

struct CustomSecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureTextField(placeHolder: "Test",password: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}


