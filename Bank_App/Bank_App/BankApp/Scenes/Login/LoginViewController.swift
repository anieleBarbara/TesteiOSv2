//
//  LoginViewController.swift
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

protocol LoginDisplayLogic: class {
  func displayStatementsList(viewModel: Login.ViewModel)
  func displayError(_ message: String?)
}

class LoginViewController: UIViewController, LoginDisplayLogic, UITextFieldDelegate {
  
  var interactor: LoginBusinessLogic?
  var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = LoginInteractor()
    let presenter = LoginPresenter()
    let router = LoginRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let destinationVC = segue.destination as! StatementsListViewController
      router?.passData(destination: destinationVC)
      
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideActivityIndicator()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    showUserSaved()
  }
    
  @IBOutlet var textFields: [UITextField]!
    
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if let index = textFields.firstIndex(of: textField) {
      if index < textFields.count - 1 {
        let nextTextField = textFields[index + 1]
        nextTextField.becomeFirstResponder()
      } else {
        textField.endEditing(true)
      }
    }
    return true
  }
  
  func showUserSaved() {
    if let field = interactor?.carragarUsuario() {
      userTextField.text = field
    } else {
      userTextField.text = ""
    }
    passwordTextField.text = ""
  }
  
  @IBOutlet weak var userTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBAction func loginTapped(_ sender: Any) {
    if let _ = interactor, interactor!.emptyField(userTextField.text, passwordTextField.text) {
      showAlertErrorMessage(message: "Todos os campos devem ser preenchidos")
    } else {
      let request = Login.Request(user: userTextField.text ?? "", password: passwordTextField.text ?? "")
      showActivityIndicator()
      interactor?.doLogin(request: request)
    }
  }
  
  func displayStatementsList(viewModel: Login.ViewModel) {
    router?.routeToStatementsList()
    hideActivityIndicator()
  }
  
  func displayError(_ message: String?) {
    hideActivityIndicator()
    showAlertErrorMessage(message: message ?? "Erro ao efetuar login")
  }
  
  func showActivityIndicator() {
    let activityIndicator:LoadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    activityIndicator.tag = 10000
    self.view.addSubview(activityIndicator)
  }
  
  func hideActivityIndicator() {
    if let activityIndicator = self.view.viewWithTag(10000) {
      activityIndicator.removeFromSuperview()
    }
  }
  
}