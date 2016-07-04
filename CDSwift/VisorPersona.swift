//
//  VisorPersonaViewController.swift
//  CDSwift
//
//  Created by Guimel Moreno on 28/06/16.
//  Copyright © 2016 Guimel Moreno. All rights reserved.
//

import UIKit

class VisorPersona: UIViewController {

    var persona : Persona?
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblEddad: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if persona != nil {
            lblNombre.text = persona?.nombre
            
            if let edad = persona?.edad {
                lblEddad.text = String(edad)
            }
            
            
            let format = NSDateFormatter()
            format.dateFormat = "dd/MM/yyyy"
            lblFecha.text = format.stringFromDate((persona?.nacimiento)!)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
