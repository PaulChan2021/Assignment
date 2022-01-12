//
//  CameraViewController.swift
//  Assignment
//
//  Created by Banana on 12/1/2022.
//

import UIKit

class CameraViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements() {
    
        // Style imageview background color
        imageView.backgroundColor = .secondarySystemBackground
        Designs.styleTakePic(button)
        
        
    }
    @IBAction func didTapButton() {
        =
    }

}
