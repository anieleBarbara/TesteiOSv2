//
//  LoginPresenter.swift
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

protocol LoginPresentationLogic {
  func presentSucess(response: Login.Response)
  func presentError(error: String)
}

class LoginPresenter: LoginPresentationLogic {
  
  weak var viewController: LoginDisplayLogic?
  
  // MARK: LoginPresentationLogic
  
  func presentSucess(response: Login.Response) {
    let viewModel = Login.ViewModel(userAccount: response.userAccount)
    viewController?.displayStatementsList(viewModel: viewModel)
  }
  
  func presentError(error: String) {
    viewController?.displayError(error)
  }
  
}
