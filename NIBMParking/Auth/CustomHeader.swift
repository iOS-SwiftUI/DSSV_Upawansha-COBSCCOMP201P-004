//
//  CustomBackButton.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct CustomHeader: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var headerTitle:String?
    
    var body: some View {
        
        HStack{
            Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 18, height: 22)
                    .foregroundColor(colorBackground)
                
            }
            Spacer()
            
            Text(headerTitle ?? "")
                .foregroundColor(Color.red)
            Spacer()
            
            ZStack {
                HStack {
                }.frame(width: 24)
            }//:ZStack
        }
        .padding(.top,39)
        .padding(.leading,16)
        .padding(.trailing,16)
        
        
    }
}

struct CustomBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomHeader()
            .previewLayout(.sizeThatFits)
    }
}
