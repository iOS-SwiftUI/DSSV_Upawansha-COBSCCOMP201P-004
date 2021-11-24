//
//  NIBM_ParkingUITests.swift
//  NIBM ParkingUITests
//
//  Created by Shanuri Vimansa on 2021-11-21.
//

import XCTest

class when_the_user_types_username_and_password_press_login_button: XCTestCase {

    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        self.app.launch()
        
    }
    
    
    func testLoginSuccess(){
        
        
        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["About Us"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.buttons["Continue as login"].tap()
        scrollViewsQuery.otherElements.containing(.image, identifier:"Logo").element.tap()
        
        let emailTF = self.app.textFields["Enter email address . . ."]
        emailTF.tap()
        emailTF.typeText("shanurivimansa@gmail.com")
        
        let passwordTF = self.app.secureTextFields["Enter password . . ."]
        passwordTF.tap()
        passwordTF.typeText("12345678")
        
        elementsQuery.buttons["Show"].tap()
        elementsQuery.buttons["Hide"].tap()
        elementsQuery.buttons["Login"].tap()
        app.alerts["Success"].scrollViews.otherElements.buttons["Ok"].tap()
                               
                        
    }
    

    
}
 



