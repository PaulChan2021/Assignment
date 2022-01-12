//
//  HomeViewController.swift
//  Assignment
//
//  Created by Banana on 12/1/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var mapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements() {
    
        // Style the elements
        Designs.styleFilledButton(cameraButton)
        Designs.styleMapButton(mapButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cameraTapped(_ sender: Any) {
        // transition to CameraVC
        let cameraViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.cameraViewController) as? CameraViewController
        
        self.view.window?.rootViewController = cameraViewController
        self.view.window?.makeKeyAndVisible()    }
    
    @IBAction func mapTapped(_ sender: Any) {
        // transition to MapVC
        let mapViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.mapViewController) as? MapViewController
        
        self.view.window?.rootViewController = mapViewController
        self.view.window?.makeKeyAndVisible()
        
    }
}
