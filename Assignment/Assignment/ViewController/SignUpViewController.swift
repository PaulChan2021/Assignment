//
//  SignUpViewController.swift
//  Assignment
//
//  Created by Banana on 10/1/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements() {
    
        // Hide the error label
        errorLabel.alpha = 0
    
        // Style the elements
        Designs.styleTextField(firstNameTextField)
        Designs.styleTextField(lastNameTextField)
        Designs.styleTextField(emailTextField)
        Designs.styleTextField(passwordTextField)
        Designs.styleFilledButton(signUpButton)
    }
    func validateFields() -> String? {
        // check the fields if it's empty
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "The field cannot be empty"
        }
        // check password security
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Designs.isPasswordValid(cleanedPassword) == false {
            return "The password cannot be less than 8 characters and contains a speical syntax "
        }
            
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
    }
}
