//
//  LoginViewController.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 03.07.2021.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleImageView: UIImageView!
    @IBOutlet private weak var titleLabelView: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Отписываемся от уведомлений клавиатуры
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginToLoading" {
            return checkInputData()
        }
        return false
    }
    
    private func checkInputData() -> Bool {
        guard
            let login = loginTextField.text,
            let password = passwordTextField.text
        else {
            print("Login or password is nil")
            return false
        }
        if login == "" && password == "" {
            sucsessLogin()
            return true
        } else {
            unsucsessLogin()
            return false
        }
    }
    
    @objc private func keyboardWasShown(notification: Notification) {           // Когда клавиатура появляется
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {        //Когда клавиатура исчезает
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    private func setView() {
        loginButton.layer.cornerRadius = 8
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    private func sucsessLogin() {
        // test parameters
        if !loginTextField.text!.isEmpty { UserSession.shared.token = loginTextField.text!
        } else {
            UserSession.shared.token = "Default_token"}
        UserSession.shared.userId = Int.random(in: 0...100)
        titleLabelView.text = "Подключаемся"
        print("Sucsessful login!")
    }
    
    private func unsucsessLogin() {
        print("Unsucsessful login!")
        showErrorAlert(message: "Неверный логин или пароль")
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel) {_ in
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
