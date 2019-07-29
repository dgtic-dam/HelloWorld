//
//  DetailViewController.swift
//  MonsterFan
//
//  Created by Infraestructura on 7/27/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var info:[String:Any] = [:]

    //@IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var datailImage: UIImageView!
    
    func configureView() {
      //  if let imageName = detailItem {
      //      let urlIMG = URL (string: <#T##String#>, relativeTo: <#T##URL?#>)
      //  }
        // Update the user interface for the detail item.
    /*    if let detail = detailItem {
            if let label = detailDescriptionLabel {
                //label.text = detail.description
            }
            
        }*/
        if let img = info["pict"] as? String {
            
            
            let URLStr = "http://janzelaznog.com/DDAM/iOS/gaga/" + img
            if let url = URL(string: URLStr){
                do {
                    let bytes = try Data(contentsOf: url) // la clase Data representa un arreglo de bytes
                    let iv = UIImageView(frame: UIScreen.main.bounds)
                    iv.contentMode = .scaleAspectFit //Para que la imagen no se estire ni se pierda la resolución
                    self.view.addSubview(iv)
                    //Se crea un objeto UImage a partir  de los bytes obtenidos de la URL
                    iv.image = UIImage(data: bytes)
                    //datailImage.image = UIImage(named: bytes)
                }
                catch {
                  //  let imageEmpty = "empty_250.png"
                   // datailImage.image = UIImage(named: imageEmpty)
                    let iv = UIImageView(frame: UIScreen.main.bounds)
                    iv.contentMode = .scaleAspectFit //Para que la imagen no se estire ni se pierda la resolución
                    self.view.addSubview(iv)
                    iv.image = UIImage(named: "empty_250.png")
                    print ("No existe la imagen " + error.localizedDescription)
                }
                //Se comenta el WebView para mostrar el image View
            }
            
        }
        else{
            //self.datailImage.image = UIImage(named:img)
            let imageEmpty = "empty_250.png"
            datailImage.image = UIImage(named: imageEmpty)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

