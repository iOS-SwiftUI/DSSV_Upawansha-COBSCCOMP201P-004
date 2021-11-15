//
//  SlotComponentVertical.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct SlotComponentVertical: View {
    
    var imageString:String?
    var textString:String?
    
    var body: some View {
        
        VStack{
            
            Image(imageString ?? "")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            
            Text(textString ?? "")
                .font(.largeTitle)
            
        }
        .frame( width:200, height: 200)
        
    }
}

struct SlotComponentVertical_Previews: PreviewProvider {
    static var previews: some View {
        SlotComponentVertical(imageString:"placeholder-image",textString:"test")
            .previewLayout(.sizeThatFits)
    }
}
