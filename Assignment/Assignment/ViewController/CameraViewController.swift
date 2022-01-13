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
        // You can take pciture when you click on Take a Photo Button
        let cameraPicker = UIImagePickerController()
        cameraPicker.sourceType = .camera
        cameraPicker.delegate = self
        present(cameraPicker, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        // back to home
        let mapViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        self.view.window?.rootViewController = mapViewController
        self.view.window?.makeKeyAndVisible()
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage else {
                    return
        }
        // once we took photo and have a image
        imageView.image = image
    }
}

