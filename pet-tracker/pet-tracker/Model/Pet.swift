//
//  Pet.swift
//  pet-tracker
//
//  Created by Colby Holmstead on 2/19/20.
//  Copyright © 2020 Colby Holmstead. All rights reserved.
//

import Foundation
import UIKit

struct PetObject{
    var id: UUID
    var name: String
    var kindOfAnimal: String
    var dateOfBirth: Date
    
    
    init(id: UUID, name: String, kindOfAnimal: String, dateOfBirth: Date){
        self.id = id
        self.name = name
        self.kindOfAnimal = kindOfAnimal
        self.dateOfBirth = dateOfBirth
    }
    
    
}
