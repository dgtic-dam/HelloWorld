//
//  SecondViewController.swift
//  VideoYAudio
//
//  Created by Infraestructura on 22/10/16.
//  Copyright © 2016 Infraestructura. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class SecondViewController: UIViewController {
    var videoPlayer:AVPlayer?
    var visto:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // buscar la URL del recurso
        let urlDelVideo = Bundle.main.url(forResource:"Comex-Omnilife", withExtension: "mp4")
        self.videoPlayer = AVPlayer(url:urlDelVideo!)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !visto {
            self.muestraVideo()
        }
    }
    func muestraVideo() {
        let videoPlayerController = AVPlayerViewController()
        videoPlayerController.player = self.videoPlayer!
        // Que device es?
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.present(videoPlayerController, animated: true, completion: {
                self.videoPlayer!.play()
                self.visto = true
            })
        }
        else { // es una tablet
            let framePantalla = UIScreen.main.bounds
            let anchoPantalla = framePantalla.size.width
            let altoPantalla = framePantalla.size.height
            videoPlayerController.view.frame = CGRect.init(x:anchoPantalla/3, y:altoPantalla/3, width:anchoPantalla/3, height:altoPantalla/3)
            self.view.addSubview(videoPlayerController.view)
            self.addChildViewController(videoPlayerController)
            self.videoPlayer?.play()
            self.visto = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.videoPlayer?.pause()
    }
}

