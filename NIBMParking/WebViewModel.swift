//
//  WebViewModel.swift
//  NIBMParking
//
//  Created by Shanuri Vimansa on 2021-11-20.
//

import Foundation
import SwiftUI
import WebKit

struct swiftUIWebView:UIViewRepresentable{
    
    let url:URL?
    
    
    func makeUIView(context: Context) -> WKWebView {
        
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        
        return WKWebView(frame: .zero,configuration: config)
         
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let myUrl = url else {
            return
        }
        
        let  request = URLRequest(url: myUrl)
        uiView.load(request)

    }
}

