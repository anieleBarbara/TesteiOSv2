//
//  LoginInteractor.swift
//  Bank_App
//
//  Created by apple on 18/03/20.
//  Copyright (c) 2020 Barbara_Aniele. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginBusinessLogic {
  func doLogin(request: Login.Request)
  func emptyField(_ user: String?, _ password: String?) -> Bool
}

protocol LoginDataStore {
  //var name: String { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
  var presenter: LoginPresentationLogic?
  var worker: LoginWorker? = LoginWorker()
  
  var user: UserAccount?
  var error: String = ""
  
  func emptyField(_ user: String?, _ password: String?) -> Bool {
    if let user = user, let password = password,
      user.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.isEmpty {
      return true
    }
    return false
  }
  
  // MARK: Do login
  
  func doLogin(request: Login.Request) {
    worker = LoginWorker()
    worker?.doLogin(request: request, completion: { (result: LoginResponse) in
      
      guard let _ = result.userAccount?.userId else {
        self.error = result.error?.message ?? "Erro ao efetuar login"
        self.presenter?.presentError(error: self.error)
        return
      }
      
      self.user = result.userAccount
      let response = Login.Response(userAccount: result.userAccount, error: result.error?.message)
      self.presenter?.presentSucess(response: response)
    })
    
    
  }
}
