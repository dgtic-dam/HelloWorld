//
//  DetailViewController.swift
//  MonsterFan
//
//  Created by Infraestructura on 7/27/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

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

