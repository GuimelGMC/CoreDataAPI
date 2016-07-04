//
//  Persona+CoreDataProperties.swift
//  CDSwift
//
//  Created by Guimel Moreno on 28/06/16.
//  Copyright © 2016 Guimel Moreno. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Persona {

    @NSManaged var id: NSNumber?
    @NSManaged var nombre: String?
    @NSManaged var edad: NSNumber?
    @NSManaged var nacimiento: NSDate?

}
