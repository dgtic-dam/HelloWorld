//
//  DetailViewController.swift
//  Estados
//
//  Created by Jan Zelaznog on 26/06/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    
    var infoEstado:[String:Any] = [:]
    var tieneVideo = false
    var muns:[[String:String]] = []
    //var munsV2:[[String]] = []
    
    @IBOutlet weak var ivEscudo: UIImageView!
    @IBOutlet weak var tvInfoMun: UITextView!
    @IBOutlet weak var lblEntidad: UILabel!
    @IBOutlet weak var pvMunicipios: UIPickerView!

    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        let destino = segue.destination as! VideoController
        //TODO: Obtener el nombredel video del diccionario o algún lado
        //........
        destino.videoNom = "Comex-Omnilife"
    }
    
    @IBAction func btnMasInfoTouch(_ sender: Any) {
        if tieneVideo{
            print("tiene video")
            // TODO: agregar otro controller y ejecutar el segue
            performSegue(withIdentifier: "video", sender: nil)
        }
        else {
            print("NO tiene video")
            if let nom = infoEstado["entidad"] as? String {
                /*let nomEncode = nom.addingPercentEncoding(withAllowedCharacters:.illegalCharacters)
                let urlString = "https://es.wikipedia.org/wiki/" + nomEncode!
 */
                let nomEncode = nom.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)
                let urlString = "https://es.wikipedia.org/wiki/" + (nomEncode ?? "") //safe unwrapping with ??
                print(urlString)
                if let url = URL(string: urlString){
                    //UIApplication es una función del sistema operativo
                    UIApplication.shared.open(url, options: [:]) { (success) in
                        if success {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let img = infoEstado["imagen"] as? String {
            self.ivEscudo.image = UIImage(named:img)
        }
        if let nom = infoEstado["entidad"] as? String {
            self.lblEntidad.text = nom.uppercased()
        }
        if let mTmp = infoEstado["municipios"] as? [[String:String]] {
            self.muns = mTmp
            self.pvMunicipios.reloadAllComponents()
            self.pickerView(pvMunicipios, didSelectRow:0, inComponent:0)
            tieneVideo = true
        }

    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return muns.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let munInfo = muns[row]
            return munInfo["nombre"]
    }
    
    //el seleccionado
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       /* if let munInfo = muns[row] as? [String:String] {
          tvInfoMun.text = munInfo["info"]
        }
        */
        if muns.count > 0 {
            let munInfo = muns[row]
            tvInfoMun.text = munInfo["info"]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pvMunicipios.delegate = self
        pvMunicipios.dataSource = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

