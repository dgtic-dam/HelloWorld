//
//  VideoController.swift
//  Estados
//
//  Created by Infraestructura on 6/29/19.
//  Copyright © 2019 Dan Ros. All rights reserved.
//

import UIKit
import Foundation
import AVKit
import AVFoundation

class VideoController: AVPlayerViewController {
    
    var videoNom:String?{
        didSet {
            self.cargaVideo()
        }
    }
    
    private func cargaVideo(){
        // video local
        // obtener la url del archivo de video:
        if let urlVideo = Bundle.main.url(forResource: videoNom, withExtension: "mp4"){
            self.player = AVPlayer(url: urlVideo)
            self.player?.play()
            //self.showsPlaybackControls = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        print ("load")
    }

}
