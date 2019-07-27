//
//  MasterViewController.swift
//  MonsterFan
//
//  Created by Infraestructura on 7/27/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit
import WebKit

class MasterViewController: UITableViewController, WKNavigationDelegate {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    
    var ac:UIAlertController?
    var timer:Timer?
    var items:[[String:Any]] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let reach = Reachability(hostName: "www.google.com"){
            let mensaje = ""
            var conexion = true
            let netStat = reach.currentReachabilityStatus()
            switch (netStat){
            case NotReachable: print ("no hay conexión")
                conexion = false
            case ReachableViaWiFi: print ("La conexión es WIFI")
            //case ReachableViaWWAN: print ("La conexión es por datos...procedo?")
            default: print ("La conexión es por datos")
            }
            //ac = UIAlertController(title: "NetStatus", message: mensaje, preferredStyle: .actionSheet)
            if !conexion {
                //Cerrar el alert automáticamente "Toast Style"
               /* timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: {
                    (localTimer) in
                    self.ac?.dismiss(animated: true, completion: nil)
                })*/
                ac = UIAlertController(title: "Esta App no funciona sin conexión a Internet", message: mensaje, preferredStyle: .alert)
                let aaOK = UIAlertAction(title: "OK", style: .destructive, handler:{
                    (alert) in
                    exit(666)
                })
                ac?.addAction(aaOK)
                present(ac!, animated: true, completion: nil)
            }
            else{
                let wv = WKWebView(frame: UIScreen.main.bounds)
                self.view.addSubview(wv)
                // Consumir JSON desde web
                let URLStr = "http://janzelaznog.com/DDAM/iOS/gaga/info.json"
                
                if let url = URL(string: URLStr){
                    do {
                        let bytes = try Data(contentsOf: url) // la clase Data representa un arreglo de bytes
                        //hacer algo con el arreglo de bytes
                        /*let unString = String(bytes:bytes, encoding: .utf8) //Conversión a String
                         print (unString)*/
                        objects = try JSONSerialization.jsonObject(with: bytes, options:.allowFragments) as! [[String : Any]]
                        print (objects)
                    }
                    catch {
                        print ("error al abrir el JSON " + error.localizedDescription)
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //navigationItem.leftBarButtonItem = editButtonItem

        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        //navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}
