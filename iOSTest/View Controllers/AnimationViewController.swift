//
//  AnimationViewController.swift
//  iOSTest
//
//  Created by D & A Technologies on 1/22/18.
//  Copyright © 2018 D & A Technologies. All rights reserved.
//

import UIKit
import AVFoundation

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     **/
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet var logoImageView: UIImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        
        self.logoImageView.alpha = 1.0
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Song", ofType: "m4a")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        
    }
    
    // MARK: - Actions
    
    @IBAction func moveLogo(_ sender: UIPanGestureRecognizer) {
        logoImageView.center = sender.location(in: view)
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        if self.logoImageView.alpha == 1.0{
            UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut, animations: {
                self.logoImageView.alpha = 0.0
                self.audioPlayer.play()
            })
        }else{
            UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut, animations: {
                self.logoImageView.alpha = 1.0
                self.audioPlayer.stop()
            })
        }
    }
}
