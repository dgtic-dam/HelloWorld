//
//  FirstViewController.swift
//  VideoYAudio
//
//  Created by Infraestructura on 22/10/16.
//  Copyright © 2016 Infraestructura. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var sliderVol: UISlider!
    @IBOutlet weak var sliderPos: UISlider!
    
    var audioPlayer:AVAudioPlayer?
    var timer:Timer?
    
    @IBAction func btnPlayTouch(sender: AnyObject) {
        self.audioPlayer!.play()
        self.btnStop.isEnabled = true
        self.btnPlay.isEnabled = false
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(FirstViewController.actualizaSlider), userInfo: nil, repeats: true)
    }
    @IBAction func btnStopTouch(sender: AnyObject) {
        self.audioPlayer!.stop()
        self.btnStop.isEnabled = false
        self.btnPlay.isEnabled = true
    }
    @IBAction func sliderVolChange(sender: AnyObject) {
        self.audioPlayer!.volume = self.sliderVol.value
    }
    @IBAction func sliderPosChange(sender: AnyObject) {
        self.audioPlayer!.currentTime = Double(self.sliderPos.value)
    }
    @objc func actualizaSlider () {
        let pos:Double = self.audioPlayer!.currentTime
        self.sliderPos.value = Float(pos)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let urlAlAudio = Bundle.main.url(forResource:"Dillon-13-36", withExtension: "mp3")
        self.cargarAudio(url: urlAlAudio!)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.btnStopTouch(sender: self.btnStop)
        self.inicializaUX()
    }
    func cargarAudio (url: URL) {
        do {
            try self.audioPlayer = AVAudioPlayer(contentsOf: url)
            self.audioPlayer!.delegate = self
            self.audioPlayer?.prepareToPlay()
            self.inicializaUX ()
        }
        catch {
            let ac = UIAlertController(title: "Error", message: "Archivo de audio invalido o inexistente", preferredStyle: .alert)
            let ab = UIAlertAction(title: "ya que...", style: .default, handler:nil)
            ac.addAction(ab)
            self.present(ac, animated: true, completion: nil)
        }
    }
    func inicializaUX() {
        self.btnStop.isEnabled = false
        self.sliderVol.minimumValue = 0.0
        self.sliderVol.maximumValue = 1.0
        self.sliderVol.value = 0.5
        self.audioPlayer!.volume = self.sliderVol.value
        self.audioPlayer!.currentTime = 0.0
        self.sliderPos.minimumValue = 0.0
        let duracion:Double = self.audioPlayer!.duration
        self.sliderPos.maximumValue = Float(duracion)
        self.sliderPos.value = 0.0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

