//
//  ViewController.swift
//  ToDoList
//
//  Created by Admin on 13.03.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    enum AlertType: String{
        case empty = "Enter all fields"
        case loginError = "Login or password is not correct"
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textFieldLogin: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notify: Notification){
        let info = notify.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height * 1.5, right: 0)
    }
    @objc private func keyboardWillHide(){
        scrollView.contentInset = .zero
    }
    @IBAction func pressEnterButton(_ sender: Any) {
        guard textFieldLogin.text != "" && textFieldPassword.text != "" else{
            showAlert(type: .empty)
            return
        }
        guard textFieldLogin.text == "1" && textFieldPassword.text == "1" else{
            showAlert(type: .loginError)
            return
        }
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationController")
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        
    }
    private func showAlert(type: AlertType){
        let alert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
}

