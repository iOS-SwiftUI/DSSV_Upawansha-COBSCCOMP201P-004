//
//  ProductCard.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-23.
//

import SwiftUI


struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
           // .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}

struct ProductCard: View {
    
    var imageString:String?
    var textString:String?
    
    
    var body: some View {
        HStack(alignment: .center) {
            
            Image(imageString ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .padding(.all, 20)
            
            VStack(alignment: .leading) {
                Text(textString ?? "")
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.black)
                
                
            }.padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(cardColor)
        .modifier(CardModifier())
        .padding(.all, 10)
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(imageString:"placeholder-image",textString:"test")
            .previewLayout(.sizeThatFits)
    }
}
