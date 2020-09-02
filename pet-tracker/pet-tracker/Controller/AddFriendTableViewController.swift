//
//  AddFriendTableViewController.swift
//  pet-tracker
//
//  Created by Colby Holmstead on 2/14/20.
//  Copyright © 2020 Colby Holmstead. All rights reserved.
//

import UIKit

class AddFriendTableViewController: UITableViewController,  UIPickerViewDelegate, UIPickerViewDataSource{
    
    var friend: Friend?
    let eyeColorArray =  [#colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.7785107493, green: 0.9457229972, blue: 0.861798048, alpha: 1)]
    let eyeColorWordArray: [String] = ["Brown", "Blue", "Green", "Hazel", "Amber", "Gray", "Red"]
    
    
    
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var eyeColorPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    
    let eyeColorPickerCellIndexPath = IndexPath(row: 1, section: 3)
    
    
    var isEyeColorPickerShown: Bool = false {
        didSet {
            eyeColorPicker.isHidden = !isEyeColorPickerShown
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        
        eyeColorPicker.dataSource = self
        eyeColorPicker.delegate = self
     
//              updateSaveButonState()
    }
    
    
    
    
    func updateSaveButonState(){
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let age = ageTextField.text ?? ""
        saveButton.isEnabled = !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !age.isEmpty
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (eyeColorPickerCellIndexPath.section, eyeColorPickerCellIndexPath.row):
            return isEyeColorPickerShown ? 216.0 : 0.0
        default:
            return 45.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (eyeColorPickerCellIndexPath.section, eyeColorPickerCellIndexPath.row - 1):
            if isEyeColorPickerShown {
                isEyeColorPickerShown = false
            } else {
                isEyeColorPickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return eyeColorWordArray.count
    }
    func pickerView(_ startNumPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        eyeColorLabel.textColor = UIColor.white
        eyeColorLabel.text = eyeColorWordArray[row]
        eyeColorLabel.backgroundColor = eyeColorArray[row]
        //              eyeColor = eyeColorWordArray[row]
        
        
        
    }
    
    func pickerView(_ startNumPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

            return eyeColorWordArray[row]
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "saveUnwind" {
            let age: Int = Int(ageTextField.text ?? "0") ?? 0
            if (firstNameTextField.text == "" || lastNameTextField.text == "" || emailTextField.text == "" || age == 0 ) {
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        
        
      
        
//    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                  fatalError("No AppDelegate Access!")
              }
              let context = appDelegate.persistentContainer.viewContext

              let friend = Friend(entity: Friend.entity(), insertInto: context)
        friend.firstName = firstNameTextField.text
        friend.lastName = lastNameTextField.text
        friend.email = emailTextField.text
        let age = ageTextField.text
        friend.age = Int16(age!)!
        friend.eyeColor = eyeColorLabel.text
        
              
              appDelegate.saveContext()
        
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField){
//                updateSaveButonState()
    }
    
    
}
