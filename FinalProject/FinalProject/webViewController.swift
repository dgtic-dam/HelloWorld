//
//  webViewController.swift
//  HamburguerMenu
//
//  Created by Infraestructura on 6/22/19.
//  Copyright © 2019 Dan Ros. All rights reserved.
//

import UIKit
import WebKit

class webViewController: UIViewController {
    
    @IBOutlet weak var webPage: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let urlWebPage = URL(string: "https://www.facebook.com/educandoensex/"){
            let theRequest = URLRequest(url: urlWebPage)
            webPage.load(theRequest)
        }
        /*if let urlPdf = Bundle.main.url(forResource: "iPho-ne Tutorial", withExtension: "pdf"){
         let theRequest = URLRequest(url: urlPdf)
         webKit.load(theRequest)
         }*/
        
    }
    
    
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
