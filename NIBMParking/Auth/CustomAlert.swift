//
//  CustomAlert.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct CustomAlert: View {
    //MARK: - PROPERITY
    @Binding var isShowAlert:Bool
    var alertTitle:String
    var alertMessage:String
    var action: (() -> ())?
    
    
    //MARK: - BODY
    var body: some View {
        Text("")
        //MARK: - ALERT
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok"),action: {
                //isShowAlert.toggle()
                action?()
            }))
        }
    }
}

//MARK: - PREVIEW
struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(isShowAlert: .constant(true), alertTitle: "Alert Titel", alertMessage:"Alert Message")
            .previewLayout(.sizeThatFits)
    }
}
