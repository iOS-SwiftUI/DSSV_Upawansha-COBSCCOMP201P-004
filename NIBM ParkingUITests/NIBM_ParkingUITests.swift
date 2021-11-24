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
        
    }
    
    func testLoginSuccess(){
        
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Enter email address . . ."].tap()
        elementsQuery.secureTextFields["Enter password . . ."].tap()
        elementsQuery.buttons["Login"].tap()
        app.alerts["Success"].scrollViews.otherElements.buttons["Ok"].tap()
                        
    }
    
    
    func testRegisterSuccess(){
        
        let app = XCUIApplication()
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.buttons["Don't you have an account? Register"].tap()
        elementsQuery.textFields["Enter name . . ."].tap()
        elementsQuery.textFields["Enter email address . . ."].tap()
        elementsQuery.textFields["Enter phone number . . ."].tap()
        elementsQuery.textFields["Enter NIC number . . ."].tap()
        
        let enterRegistrationNumberTextField = elementsQuery.textFields["Enter registration number . . ."]
        enterRegistrationNumberTextField.tap()
        
        let enterVehicleNumberTextField = elementsQuery.textFields["Enter vehicle number . . ."]
        enterVehicleNumberTextField.tap()
        enterRegistrationNumberTextField.tap()
        enterRegistrationNumberTextField.tap()
        enterVehicleNumberTextField.tap()
        elementsQuery.secureTextFields["Enter password . . ."].tap()
        elementsQuery.secureTextFields["Enter confirm password . . ."].tap()
        
        let logoElement = scrollViewsQuery.otherElements.containing(.image, identifier:"Logo").element
        logoElement.swipeUp()
        logoElement.swipeUp()
        logoElement.swipeUp()
        enterRegistrationNumberTextField.tap()
        elementsQuery.children(matching: .button).matching(identifier: "Show").element(boundBy: 0).tap()
        elementsQuery.buttons["Hide"].tap()
        
        let showButton = elementsQuery.children(matching: .button).matching(identifier: "Show").element(boundBy: 1)
        showButton.tap()
        showButton.tap()
        elementsQuery.buttons["Sign Up"].tap()
        app.alerts["Success"].scrollViews.otherElements.buttons["Ok"].tap()
                
    }
    
    
}
 
