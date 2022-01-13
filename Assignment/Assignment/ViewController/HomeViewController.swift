//
//  HomeViewController.swift
//  Assignment
//
//  Created by Banana on 12/1/2022.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {

    var VideoPlayer:AVPlayer?
    var Videolayer:AVPlayerLayer?
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var mapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // video for login background
        backgroundSetup()
    }
    
    func backgroundSetup() {
        //get resource and create URL
        let Path = Bundle.main.path(forResource: "ICON_VERSION7", ofType: "mp4")
        guard Path != nil else{
            return
        }
        let url = URL(fileURLWithPath: Path!)
        // display video for background and scaling
        let VideoItem = AVPlayerItem(url: url)
        VideoPlayer = AVPlayer(playerItem: VideoItem)
        
        // create the layer
        Videolayer = AVPlayerLayer(player: VideoPlayer!)
        
        // scaling
        Videolayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)

        view.layer.insertSublayer(Videolayer!, at: 0)
        
        // play video in login background
        VideoPlayer?.playImmediately(atRate: 0.3)
    }
    
    func setUpElements() {
    
        // Style the elements
        Designs.styleFilledButton(cameraButton)
        Designs.styleMapButton(mapButton)
    }

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
