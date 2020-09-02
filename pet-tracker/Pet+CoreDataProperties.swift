//
//  Pet+CoreDataProperties.swift
//  pet-tracker
//
//  Created by Colby Holmstead on 3/16/20.
//  Copyright © 2020 Colby Holmstead. All rights reserved.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var name: String?
    @NSManaged public var kindOfAnimal: String?
    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var friend: Friend?

}
