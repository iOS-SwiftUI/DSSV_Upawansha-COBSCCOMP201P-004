//
//  CustomDoubleLabel.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct CustomLabelAndNotEditableTextField: View {
    
    var labelTxt:String?
    @Binding var valueText:String

    
    var body: some View {
        
        VStack{
            HStack{
            Text(labelTxt ?? "Test")
                Spacer()
            }
            CustomTextField(placeHolder: labelTxt ?? "", valueText: $valueText)
                .disabled(true)
        }
    }
}

struct CustomDoubleLabel_Previews: PreviewProvider {
    static var previews: some View {
        CustomLabelAndNotEditableTextField(labelTxt:"", valueText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
