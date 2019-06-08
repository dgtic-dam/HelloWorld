//
//  SecondViewController.swift
//  UiBasics
//
//  Created by Infraestructura on 6/8/19.
//  Copyright © 2019 Dan Ros. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func unwindToSecondView(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
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
