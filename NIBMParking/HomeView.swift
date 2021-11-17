//
//  HomeView.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI
import RappleProgressHUD


public struct SectionView: View {
    var section: Int
    public var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 275, height: 275, alignment: .center)
            Text("\(section)")
                .foregroundColor(.white)
        }
    }
}

struct HomeView: View {
    
    @State private var isShowingNumber: Int = 0

    @StateObject var vm = HomeVM()
    
    var body: some View {
        
        ZStack {
            //colorBackground
            VStack {
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 20) {
                     
                            Text("VIP Slots")
                                .foregroundColor(colorBackground)
                                .font(.largeTitle)
                           
                            
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach (vm.vipSlotList,id:\.slotId){ slotItem in
                                        SlotComponentVertical(imageString:"placeholder-image",textString:"test")
                                            .onTapGesture {
                                                print("tapped \(slotItem.slotId) ")
                                            }
                                    }
                               }
                            }
                            
                            
                            Text("Normal Slots")
                                .foregroundColor(colorBackground)
                                .font(.largeTitle)
                            
                            VStack{
                                ForEach (vm.normalSlotList,id:\.slotId){ slotItem in
                                    SlotComponentHorizontal(imageString:"placeholder-image",textString:"test")
                                }
                                
                            }
                            
                        }
                        .frame(minHeight: geometry.size.height)
                        .padding(.all,20)
                    }
                    .frame(width: geometry.size.width)
                }
            }
            
            CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
        }.onAppear{
            RappleActivityIndicatorView.startAnimating()
            vm.fetchSlots { status in
                RappleActivityIndicatorView.stopAnimation()


                if status{
                    print("success  !!!!")
                    print(vm.vipSlotList)
                    print(vm.normalSlotList)
                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
