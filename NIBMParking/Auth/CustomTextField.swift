//
//  CustomTextField.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct CustomTextField: View {
    
    var placeHolder:String
    @Binding var valueText:String
    
    var body: some View {
        TextField(placeHolder, text: $valueText)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(colorBackground, style: StrokeStyle(lineWidth: 1.0)))
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(placeHolder: "Test", valueText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
