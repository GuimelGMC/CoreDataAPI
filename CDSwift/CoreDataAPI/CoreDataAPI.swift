//
//  CoreDataAPI.swift
//  CoreData
//
//  Created by Guimel Moreno on 28/06/16.
//  Copyright © 2016 Guimel Moreno. All rights reserved.
//

import UIKit
import CoreData

enum ComandosCoreDataAPI {
    case Select
    case Insert
    case Delete
}

class CoreDataAPI: NSObject {
    
    static let instanciaCompartida = CoreDataAPI()
    
    var context : NSManagedObjectContext?
    var model : NSManagedObjectModel?
    var psc : NSPersistentStoreCoordinator?
    
    
    private override init(){
        
    }
    
    private func procesarFetchResult(asynchronousFetchResult : NSAsynchronousFetchResult) -> [NSManagedObject] {
        var results = [NSManagedObject]()
        if let result = asynchronousFetchResult.finalResult {
            results = result as! [NSManagedObject]
        }
        return results
    }
    
    func ejecutaComando(comando : ComandosCoreDataAPI, conEntidad entidad : AnyObject , yPredicado predicado : NSPredicate?) -> NSDictionary {
        let informacionObtenida = NSMutableDictionary()
        switch comando {
        case .Select:
            let peticion = NSFetchRequest()
            peticion.entity = NSEntityDescription.entityForName(entidad as! String, inManagedObjectContext: CoreDataAPI.instanciaCompartida.context!)
            peticion.predicate = predicado
            do{
                let consultaResult = try CoreDataAPI.instanciaCompartida.context?.executeRequest(peticion) as! NSAsynchronousFetchResult
                let resultados = self.procesarFetchResult(consultaResult)
                
                informacionObtenida.setObject(resultados, forKey: "results")
            }catch let error as NSError{
                print("=== ERROR COREDATAAPI ===\n\nCOMANDO =   SELECT\nDESCRIPCION =   \(error.localizedDescription)")
            }
            break
        case .Insert:
            informacionObtenida.setObject(NSEntityDescription.insertNewObjectForEntityForName(entidad as! String, inManagedObjectContext: CoreDataAPI.instanciaCompartida.context!), forKey: "newEntity")
            break
        case .Delete:
            CoreDataAPI.instanciaCompartida.context?.deleteObject(entidad as! NSManagedObject)
            print("=== LOG COREDATAAPI ===\n\nCOMANDO   =   DELETE\nENTIDAD   =   \(entidad)")
            break
        }
        return informacionObtenida
    }
    
    func salvarContexto() -> Bool{
        do{
            try CoreDataAPI.instanciaCompartida.context?.save()
            print("=== LOG COREDATAAPI ===\n\nMENSAJE = SE GUARDO EL CONTEXTO")
            return true
        }catch let error as NSError {
            print("=== ERROR COREDATAAPI ===\n\nCOMANDO = SalvarCotexto\nDESCRIPCION = \(error.localizedDescription)")
            return false
        }
    }

    
    
}
