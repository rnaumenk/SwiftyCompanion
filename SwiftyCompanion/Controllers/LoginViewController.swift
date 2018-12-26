//
//  TestViewController.swift
//  SwiftyCompanion
//
//  Created by Ruslan on 03.11.2018.
//  Copyright © 2018 Ruslan NAUMENKO. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    private let apiController = APIController()
    private let bgImageView = UIImageView()
    private let button = SearchButton()
    private let textField = UITextField()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        // Create UI
        setNavBar()
        setBgImageView()
        setTextField()
        setButton()
        
        //Notification Center
        NotificationCenter.default.addObserver(self, selector: #selector(updateViewFrame), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateViewFrame), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // first view controller navigation bar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.8
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 2
    }
    
    // second view controller navigation bar
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }

    //MARK: - UI creation methods
    
    /// Installation of the navigation bar
    private func setNavBar() {
        navigationItem.title = "Enter login"
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Enter login"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.textColor = .white
        navigationItem.titleView = label
        
    }
    
    /// Installation of the background image
    private func setBgImageView() {
        if let image = UIImage(named: "intra_background") {
            bgImageView.image = image
        }
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgImageView)
        
        bgImageViewConstraints()
    }
    
    /// Installation of the text field
    private func setTextField() {
        textField.tintColor = UIColor.black
        textField.borderStyle = .roundedRect
        textField.contentVerticalAlignment = .center
        textField.textAlignment = .center
        textField.placeholder = "login"
        textField.rightViewMode = .unlessEditing
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        textFieldConstraints()
    }
    
    /// Installation of the button
    private func setButton() {
        button.layer.cornerRadius = 5
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(red: 77/255, green: 206/255, blue: 149/255, alpha: 1)
        button.setTitle("Search user", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchUser), for: .touchUpInside)
        view.addSubview(button)
        
        buttonConstraints()
    }
    
    //MARK: - Constraints methods
    
    /// Constraints of the background image
    private func bgImageViewConstraints() {
        bgImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bgImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    /// Constraints of the text field
    private func textFieldConstraints() {
        textField.widthAnchor.constraint(equalToConstant: 136).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    /// Constraints of the button
    private func buttonConstraints() {
        button.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: textField.heightAnchor).isActive = true
        button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8.0).isActive = true
    }
    
    //MARK: - UIResponder methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    //MARK: - Selectors
    
    /// Offset the view when the keyboard comes out
    ///
    /// - Parameter notification: contains the userinfo dictionary property from which the user keyboard frame can be obtained
    @objc func updateViewFrame(notification: NSNotification) {
        guard let userinfo = notification.userInfo else {return}
        
        let getKeyBoardRect = (userinfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        switch notification.name {
        case UIResponder.keyboardWillShowNotification:
            if button.frame.origin.y + button.frame.height > getKeyBoardRect.origin.y {
                view.frame.origin.y = 0
                view.frame.origin.y -= button.frame.origin.y + button.frame.height - getKeyBoardRect.origin.y + 8
            }
        default:
            view.frame.origin.y = 0
        }
    }
    
    /// Perform the action for the button
    @objc func searchUser() {
        UIView.animate(withDuration: 0.2, animations: {
            self.button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            UIView.animate(withDuration: 0.2, animations: {
                self.button.transform = CGAffineTransform.identity
            })
        }
        textField.text = textField.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if textField.text?.isEmpty == false {
            
            button.isEnabled = false
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            button.startLoading()

            let login = textField.text!
            DispatchQueue.global().async {
                self.apiController.checkToken()
    
                self.apiController.getUser(login) { (user) in
        
                    DispatchQueue.main.async {
                        
                        if self.textField.isFirstResponder {
                            self.textField.resignFirstResponder()
                        }
                        self.button.stopLoading()
                        self.button.isEnabled = true
                        
                        guard user?.count != 0 else {
                            self.displayAlert(message: "User doesn't exist")
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            return
                        }
                        
                        let userVC = UserViewController()
                        userVC.user = UserModel(user!)
                        self.navigationController?.pushViewController(userVC, animated: true)
                    }
                }
            }
        }
    }
    
    //MARK: - Alert method
    
    /// Display an allert controller
    ///
    /// - Parameter message: message to be shown
    private func displayAlert(message: String)
    {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
            
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }
}
