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
                        Image("3d")
                        Text("Slots")
                            .foregroundColor(colorBackground)
                        
                    }
                
                if LocalUser.shared.checkLocalUser(){
                    
                    BookingView()
                        .tabItem {
                            Image(systemName: "phone.fill")
                            Text("Bookings")
                            
                        }
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "phone.fill")
                            Text("Profile")
                            
                        }
                }else{
                    
                    AboutUs()
                        .tabItem {
                            Image(systemName: "phone.fill")
                            Text("Login")
                            
                        }
                }
                
            }
            .navigationBarHidden(true)


        }
        
        
    }
}


struct BottomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabBar()
    }
}
