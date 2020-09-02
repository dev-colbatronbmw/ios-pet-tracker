//
//  FriendCollectionViewCell.swift
//  pet-tracker
//
//  Created by Colby Holmstead on 2/14/20.
//  Copyright © 2020 Colby Holmstead. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var eyeColorTextField: UITextField!
    
    func setup(friend: Friend){
        friendImageView.image = UIImage(named: "person")
        nameLabel.text = "\(friend.firstName!) \(friend.lastName!)"
        emailLabel.text = friend.email
        ageLabel.text = String(friend.age)
        
        switch friend.eyeColor {
        case "Brown":
            eyeColorTextField.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        case "Blue":
            eyeColorTextField.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case "Green":
            eyeColorTextField.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        case "Hazel":
            eyeColorTextField.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        case "Amber":
            eyeColorTextField.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        case "Gray":
            eyeColorTextField.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        case "Red":
            eyeColorTextField.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        default:
            eyeColorTextField.backgroundColor = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        }
        
        
        
        
        
    }
    
    
    
    
}
