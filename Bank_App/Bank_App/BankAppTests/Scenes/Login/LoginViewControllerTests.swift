//
//  LoginViewControllerTests.swift
//  BankApp
//
//  Created by apple on 22/03/20.
//  Copyright (c) 2020 Barbara_Aniele. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import BankApp
import XCTest

class LoginViewControllerTests: XCTestCase {
  
  // MARK: Subject under test
  
  var sut: LoginViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupLoginViewController()
  }
  
  override func tearDown() {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupLoginViewController() {
    let bundle = Bundle(for: type(of: self))
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    _ = loginVC.loadViewIfNeeded()
    sut = loginVC
  }
  
  func loadView() {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Tests
  
  func testChangeInUserTextFieldWithBlankText() {
    sut.userTextField.insertText("")
    
    XCTAssert(sut.userTextField.text == "")
  }
  
  func testChangeInPasswordTextFieldWithBlankText() {
    sut.passwordTextField.insertText("")
    
    XCTAssert(sut.passwordTextField.text == "")
  }
  
  func testChangeInUserTextFieldValidEmail() {
    sut.userTextField.insertText("teste@ios.com")
    
    XCTAssert(sut.userTextField.text?.isValidEmail == true)
  }
  
  func testChangeInUserTextFieldValidCPF() {
    sut.userTextField.insertText("12345678909")
    
    XCTAssert(sut.userTextField.text?.isValidCPF == true)
  }
}
