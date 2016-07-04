//
//  AddPersona.swift
//  CDSwift
//
//  Created by Guimel Moreno on 28/06/16.
//  Copyright © 2016 Guimel Moreno. All rights reserved.
//

import UIKit

class AddPersona: UITableViewController {
    
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtEdad: UITextField!
    @IBOutlet weak var txtNacimiento: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cancelar(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func guardar(sender: AnyObject) {
        let persona = CoreDataAPI.instanciaCompartida.ejecutaComando(ComandosCoreDataAPI.Insert, conEntidad: "Persona", yPredicado: nil).objectForKey("newEntity") as! Persona
        
        persona.nombre = txtNombre.text
        let edadInt = Int(txtEdad.text!)
        persona.edad = NSNumber(integer: edadInt!)
        
        let format = NSDateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let fechaEdad = format.dateFromString(txtNacimiento.text!)
        persona.nacimiento = fechaEdad
        
        CoreDataAPI.instanciaCompartida.salvarContexto()
        self.cancelar(self)
    }
   
}
