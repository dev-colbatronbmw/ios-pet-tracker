//
//  PetsCollectionViewCell.swift
//  pet-tracker
//
//  Created by Colby Holmstead on 2/14/20.
//  Copyright © 2020 Colby Holmstead. All rights reserved.
//

import UIKit

class PetsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petKindLebel: UILabel!
    @IBOutlet weak var petDateOfBirthLabel: UILabel!
    
    func setup(pet: Pet){
        petImageView.image = UIImage(named: "pet")
        petNameLabel.text = pet.name
        petKindLebel.text = pet.kindOfAnimal
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        petDateOfBirthLabel.text = dateFormatter.string(from: pet.dateOfBirth!)
    }
}
