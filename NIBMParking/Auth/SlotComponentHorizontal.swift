//
//  SlotComponent.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct SlotComponentHorizontal: View {
    
    var imageString:String?
    var textString:String?
    
    var body: some View {
        
        HStack{
            
            Spacer()
            Image(imageString ?? "")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
    
            Text(textString ?? "")
                .font(.largeTitle)
            
            Spacer()
        }
        .frame( height: 150
        )
    }
}

struct SlotComponent_Previews: PreviewProvider {
    static var previews: some View {
        SlotComponentHorizontal(imageString:"placeholder-image",textString:"test")
            .previewLayout(.sizeThatFits)
    }
}
