//
//  ViewController.swift
//  Persistence
//
//  Created by Mac Mini Edg3 on 22/06/18.
//  Copyright © 2018 janzelaznog. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var txtKey: UITextField!
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var swPlist: UISwitch!
    @IBOutlet weak var swJson: UISwitch!
    @IBOutlet weak var swUserD: UISwitch!
    @IBOutlet weak var btnGuardar: UIButton!
    
    @IBAction func btnGuardarTouch(_ sender: Any) {
        var tipo = PersistenceType.plistFile
        if swUserD.isOn {
            tipo = PersistenceType.userDefaults
        }
        else if swJson.isOn {
            tipo = PersistenceType.jsonFile
        }
        var mensaje = "Ocurrió un error al tratar de guardar la información"
        if PersistenceManager.getInstance().guarda(txtValue.text!, enKey:txtKey.text!, tipo:tipo) {
            mensaje = "Se guardó la información correctamente"
        }
        let ac = UIAlertController(title: "RESULTADO", message: mensaje, preferredStyle: .alert)
        let aa = UIAlertAction(title: "ok", style: .default, handler: nil)
        ac.addAction(aa)
        self.present(ac, animated:true)
    }
    
    @IBAction func textFieldChange(_ textField: UITextField) {
        var text1:String?
        let text2 = textField.text
        if textField.isEqual(txtKey) {
            text1 = txtValue.text
        }
        else {
            text1 = txtKey.text
        }
        btnGuardar.isEnabled = (text1 != "" && text2 != "")
    }
    
    @IBAction func swChange(_ sender: UISwitch) {
        let val = sender.isOn
        if (val) {
            if sender.isEqual(swPlist) {
                swJson.isOn = !val
                swUserD.isOn = !val
            }
            else if sender.isEqual(swJson) {
                swPlist.isOn = !val
                swUserD.isOn = !val
            }
            else {
                swPlist.isOn = !val
                swJson.isOn = !val
            }
        }
        else {
            swPlist.isOn = true
            swJson.isOn = false
            swUserD.isOn = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        swJson.isOn = false
        swUserD.isOn = false
        btnGuardar.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

