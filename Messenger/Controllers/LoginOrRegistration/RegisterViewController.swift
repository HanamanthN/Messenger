//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Hanamantraya Nagonde on 08/09/21.
//

import UIKit

class RegisterViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        emailField.returnKeyType = .continue
        emailField.layer.cornerRadius = 12
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        emailField.placeholder = "Email Address...."
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        emailField.leftViewMode = .always
        emailField.backgroundColor = .white
        return emailField
    }()
    
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.returnKeyType = .done
        passwordField.layer.cornerRadius = 12
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.placeholder = "Password"
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        passwordField.leftViewMode = .always
        passwordField.backgroundColor = .white
        passwordField.isSecureTextEntry = true
        return passwordField
    }()
    
    private let registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemGreen
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 12
        registerButton.layer.masksToBounds = true
        registerButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return registerButton
    }()
    
    private let firstNameField: UITextField = {
        let firstNameField = UITextField()
        firstNameField.autocorrectionType = .no
        firstNameField.autocapitalizationType = .none
        firstNameField.returnKeyType = .continue
        firstNameField.layer.cornerRadius = 12
        firstNameField.layer.borderWidth = 1
        firstNameField.layer.borderColor = UIColor.lightGray.cgColor
        firstNameField.placeholder = "First Name"
        firstNameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        firstNameField.leftViewMode = .always
        firstNameField.backgroundColor = .white
        return firstNameField
    }()
    
    private let lastNameField: UITextField = {
        let lastNameField = UITextField()
        lastNameField.autocorrectionType = .no
        lastNameField.autocapitalizationType = .none
        lastNameField.returnKeyType = .continue
        lastNameField.layer.cornerRadius = 12
        lastNameField.layer.borderWidth = 1
        lastNameField.layer.borderColor = UIColor.lightGray.cgColor
        lastNameField.placeholder = "Last Name"
        lastNameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        lastNameField.leftViewMode = .always
        lastNameField.backgroundColor = .white
        return lastNameField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create Account"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .done, target: self, action: #selector(didTapRegister))
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add Subview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePicture))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 3
        imageView.frame = CGRect(x: (scrollView.width - size) / 2, y: 20, width: size, height: size)
        firstNameField.frame = CGRect(x: 30, y: imageView.bottom + 10, width: scrollView.width - 60, height: 52)
        lastNameField.frame = CGRect(x: 30, y: firstNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        emailField.frame = CGRect(x: 30, y: lastNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        passwordField.frame = CGRect(x: 30, y: emailField.bottom + 10, width: scrollView.width - 60, height: 52)
        registerButton.frame = CGRect(x: 30, y: passwordField.bottom + 10, width: scrollView.width - 60, height: 52)
    }
    
    @objc private func registerButtonTapped() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        guard let firstName = firstNameField.text, let lastName = lastNameField.text, let email = emailField.text, let password = passwordField.text, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        // Firebase Login
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to create new account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapChangeProfilePicture() {
        print("Change pic called")
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
}
