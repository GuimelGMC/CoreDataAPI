//
//  ViewController.swift
//  CDSwift
//
//  Created by Guimel Moreno on 28/06/16.
//  Copyright © 2016 Guimel Moreno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var personas = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView!
//MARK: Ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.dataSource = self
        tableView.delegate = self
        
        personas = (CoreDataAPI.instanciaCompartida.ejecutaComando(ComandosCoreDataAPI.Select, conEntidad: "Persona", yPredicado: nil).objectForKey("results") as! NSArray).mutableCopy() as! NSMutableArray
        tableView.reloadData()
    }
    @IBAction func editarTable(sender: AnyObject) {
        if self.tableView.editing == true {
            self.tableView.editing = false
        } else {
            self.tableView.editing = true
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "personaSegue" {
            let ip = sender as! NSIndexPath
            let persona = personas.objectAtIndex(ip.row) as! Persona
            let visor = segue.destinationViewController as! VisorPersona
            visor.persona = persona
        }
    }

}
//MARK: UITableViewDataSource
extension ViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personas.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        let persona = personas.objectAtIndex(indexPath.row) as! Persona
        cell?.textLabel?.text = persona.nombre
        return cell!
    }
}
//MARK: UITableViewDelegate
extension ViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("personaSegue", sender: indexPath)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let persona = personas.objectAtIndex(indexPath.row) as! Persona
            
            CoreDataAPI.instanciaCompartida.ejecutaComando(ComandosCoreDataAPI.Delete, conEntidad: persona, yPredicado: nil)
            CoreDataAPI.instanciaCompartida.salvarContexto()
            
            tableView.beginUpdates()
            personas.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
            tableView.endUpdates()
        }
    }
}