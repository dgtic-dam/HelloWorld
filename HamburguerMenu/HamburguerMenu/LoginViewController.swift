//
//  LoginViewController.swift
//  HamburguerMenu
//
//  Created by Infraestructura on 6/21/19.
//  Copyright © 2019 Dan Ros. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    

    @IBOutlet weak var subStack1: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        //994fb6
        //let miColor = UIColor(red: 130.0/255.0, green: 36.0/255.0, blue: 227.0/255.0, alpha: 1.0)
        let miColor = Utils.mainColor
        let bg = UIView(frame: subStack1.bounds)
        bg.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bg.backgroundColor = miColor
        subStack1.insertSubview(bg, at:0)
        let bg2 = UIView(frame: subStack1.bounds)
        bg2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bg2.backgroundColor = miColor
        subStack2.insertSubview(bg2, at:0)
    }
    
    @IBOutlet weak var subStack2: UIStackView!
    
    @IBOutlet weak var subStack3: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
