//
//  ViewController.swift
//  Eventos
//
//  Created by Infraestructura on 8/10/19.
//  Copyright © 2019 Daniel Rosales. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {
    
    let eventStore = EKEventStore()
   
    @IBOutlet weak var dpDate: UIDatePicker!

    @IBOutlet weak var btnAgenda: UIButton!
    
    @IBAction func btnAgendaTouch(_ sender: Any) {
        let fechaEvento = dpDate.date

        if fechaEvento <= Date() {
            let ac = UIAlertController(title: "", message: "Seriously?", preferredStyle: .alert)
            let aa = UIAlertAction(title: "sorry", style: .default, handler: nil)
            ac.addAction(aa)
            present(ac,animated: true,completion: nil)
        }
        else {
            // agendar el evento
            let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
            if status == EKAuthorizationStatus.notDetermined {
                eventStore.requestAccess(to: .event, completion:
                    {(granted: Bool, error: Error?) -> Void in
                        if granted {
                            print("Access granted")
                        } else {
                            print("Access denied")
                        }
                })
            }
            else if status == .denied {
                let ac = UIAlertController(title: "Error", message: "Debe autorizar el uso del calendario, desde Configuración, quiere autorizarlo ahora?", preferredStyle: .alert)
                let a1 = UIAlertAction(title: "SI", style: .default) { (alert) in UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler:nil)
                }
                ac.addAction(a1)
                let a2 = UIAlertAction(title: "No", style: .default, handler: nil)
                ac.addAction(a2)
                present(ac, animated: true, completion: nil)
            }
            else {
                self.saveEvent()
            }
        }
    }
    
    func saveEvent(){
        //Objeto para convertir fechas a String y viceversa
        let dateFormatter = DateFormatter()
        //Los eventos en el calendario se deben agregar con el huso horario central
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let strDate = dateFormatter.string(from: dpDate.date)
        let newDate = dateFormatter.date(from: strDate)
        dateFormatter.timeZone = TimeZone.current
        // Obtenemos la fecha de fin del evento, (una hora después de la fecha de inicio)
        let endDate: Date = newDate!.addingTimeInterval(3600)
        DispatchQueue.global(qos: .background).async { () -> Void in
            self.eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if (granted) && (error == nil) {
                    //Para que el evento se repita diario
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let farAwayDate = dateFormatter.date(from: "2019-12-31")
                    let endRule = EKRecurrenceEnd(end:farAwayDate!)
                    let ekrules: EKRecurrenceRule = EKRecurrenceRule.init(recurrenceWith: EKRecurrenceFrequency.daily, interval: 3, end: endRule)
                    let event = EKEvent(eventStore: self.eventStore)
                    
                    event.title = "DDAM_V2"
                    event.startDate = newDate
                    event.endDate = endDate
                    event.notes = "¡Recuerda tu TAREA del Diplomado iOS!"
                    event.addAlarm(EKAlarm(relativeOffset: -300))
                    //Para establecer la recurrencia del evento
                    event.addRecurrenceRule(ekrules)
                    event.calendar = self.eventStore.defaultCalendarForNewEvents
                    do {
                        try self.eventStore.save(event, span: .thisEvent)
                        //Para identificar los eventos creados por mi aplicación:
                        //guarda el id del eventoen BD para poder editarlo después
                        //event.eventIdentifier
                        let eventId = event.eventIdentifier!
                        // TODO: obtener arreglo de eventos por rango de fechas y después filtrar el arreglo por el eventID
                       /*let predicate = self.eventStore.predicateForEvents(withStart: newDate, end: endDate, calendars: defaultCalendarForNewEvents)
                        let oldEvent = self.eventStore.events(matching: predicate).first
                        */
                        // Ahora puedes modificar las propiedades del evento:
                        // ......
                        // Para eliminar un evento:
                       /* do{
                            try self.eventStore.remove(oldEvent!, span: .thisEvent)
                        }
                        catch{
                            
                        }*/
                    }
                    catch  {
                        
                    }
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

