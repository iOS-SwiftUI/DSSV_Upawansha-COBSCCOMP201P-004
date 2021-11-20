//
//  BottomTabBar.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-15.
//

import SwiftUI
import Combine
import Firebase



public let Authenticated = PassthroughSubject<Bool, Never>()

//check the status of local user
public func IsAuthenticated() -> Bool {
    
    if Auth.auth().currentUser != nil{
        return  true
        
    }else{
        return false
    }
    
}



struct BottomTabBar: View {
    
    @State var isAuthenticated = IsAuthenticated()
    
    init(){
        
        //MARK: - FOR TAB BAR ISSUE IOS 15
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        //MARK: - TAB BAR COLOR SET TO WHITE
        // change the tab bar style
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundEffect = .none
        tabBarAppearance.backgroundColor = UIColor.white
        tabBarAppearance.shadowColor = UIColor.clear
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
    }
    
    var body: some View {
        
        NavigationView {
            
            TabView {
                
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "square.and.pencil")
                    }
                
                
                if isAuthenticated {
                    
                    BookingView()
                        .tabItem {
                            Label("Bookings", systemImage: "square.and.pencil")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "square.and.pencil")
                        }
                    
                    
                }else{
                    
                    AboutUs()
                        .tabItem {
                            Label("About Us", systemImage: "square.and.pencil")
                        }
                }
                
                
            }//:TabView
            .onReceive(Authenticated, perform: {
                isAuthenticated = $0
            })
            
            .navigationBarHidden(true)
            .navigationTitle("")
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        
    }
}


struct BottomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabBar()
    }
}
