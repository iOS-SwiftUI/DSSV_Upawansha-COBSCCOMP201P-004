//
//  Terms.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-20.
//

import SwiftUI

struct Terms: View {
    var body: some View {
        
        ZStack {
            //colorBackground
            VStack {
                CustomHeader()
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 60) {
                            
                            swiftUIWebView(url: URL(string: "https://www.lipsum.com/privacy.pdf"))
                            
                        }
                        .frame(minHeight: geometry.size.height)
                        .padding(.all,20)
                    }
                    .frame(width: geometry.size.width)
                }
            }//VStack
            
        }//ZSTACK
        
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct Terms_Previews: PreviewProvider {
    static var previews: some View {
        Terms()
    }
}
