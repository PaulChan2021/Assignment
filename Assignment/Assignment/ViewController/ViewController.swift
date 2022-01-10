//
//  ViewController.swift
//  Assignment
//
//  Created by Banana on 10/1/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        
        Designs.styleFilledButton(signUpButton)
        Designs.styleHollowButton(loginButton)
        
    }
}

