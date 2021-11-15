//
//  BottomTabBar.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI

struct BottomTabBar: View {
    var body: some View {
        
        NavigationView{
            TabView{
                
                HomeView()
                    .tabItem {
                        Image(systemName: "phone.fill")
                        Text("First Tab")
                        
                    }
                
                BookingView()
                    .tabItem {
                        Image(systemName: "phone.fill")
                        Text("Second Tab")
                        
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "phone.fill")
                        Text("First Tab")
                        
                    }
            }
        
        }
    }
}

struct BottomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabBar()
    }
}
