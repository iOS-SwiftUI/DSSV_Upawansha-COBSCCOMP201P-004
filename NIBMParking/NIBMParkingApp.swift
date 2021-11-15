//
//  NIBMParkingApp.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-14.
//

import SwiftUI
import Firebase

@main
struct NIBMParkingApp: App {
    
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
