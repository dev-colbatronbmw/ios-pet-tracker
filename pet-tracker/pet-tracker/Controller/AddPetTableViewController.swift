//
//  AddPetTableViewController.swift
//  pet-tracker
//
//  Created by Colby Holmstead on 2/19/20.
//  Copyright © 2020 Colby Holmstead. All rights reserved.
//

import UIKit
import CoreData

class AddPetTableViewController: UITableViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    var friend: Friend?
    var petObject: PetObject?
    var pet: Pet?
    let kindOfPetsArray = ["", "Dog", "Cat", "fish", "Rabbit", "Bird", "Ferret", "Horse", "Lizzard", "Snake", "Sugar Glider", "Hedgehog", "Guinea pig", "Hamster", "Sheep", "Turtle", "Rodent", "Goat", "Iguana", "Llama", "Frog", "Chinchilla", "Tortois"]
    let dateOfBithPickerIndexPath = IndexPath(row: 1, section: 2)
    let kindOfAnimalPickerIndexPath = IndexPath(row: 1, section: 1)
    
    var isDatePickerShown: Bool = false{
        didSet{
            dateOfBirthPicker.isHidden = !isDatePickerShown
        }
    }
    var isKindOfAnimalPickerShown: Bool = false{
        didSet{
            kindOfPetPicker.isHidden = !isKindOfAnimalPickerShown
        }
    }
    
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var kindOfPetLabel: UILabel!
    @IBOutlet weak var kindOfPetPicker: UIPickerView!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        updateViews()
        kindOfPetPicker.dataSource = self
        kindOfPetPicker.delegate = self
        
         print(friend!)
//        print(friend!.pets!.count)
//               print(friend!.firstName!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        print(friend!)
    }
    
    @IBAction func datePickerValueChanged( _ sender: UIDatePicker){
        updateViews()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (dateOfBithPickerIndexPath.section, dateOfBithPickerIndexPath.row):
            return isDatePickerShown ? 216.0 : 0.0
        case (kindOfAnimalPickerIndexPath.section, kindOfAnimalPickerIndexPath.row):
            return isKindOfAnimalPickerShown ? 216.0 : 0.0
        default:
            return 45.0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (dateOfBithPickerIndexPath.section, dateOfBithPickerIndexPath.row - 1):
            if isDatePickerShown {
                isDatePickerShown = false
            } else {
                isDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (kindOfAnimalPickerIndexPath.section, kindOfAnimalPickerIndexPath.row - 1):
            if isKindOfAnimalPickerShown {
                isKindOfAnimalPickerShown = false
            } else {
                isKindOfAnimalPickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    
    
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 5
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "savePetUnwind" else { return }
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("No AppDelegate Access!")
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let pet = Pet(entity: Pet.entity(), insertInto: context)
        pet.name = petNameTextField.text!
        pet.kindOfAnimal = kindOfPetLabel.text!
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "MM dd,yyyy"
        let date = dateFormatter.date(from:dateOfBirthLabel.text!)!
        pet.dateOfBirth = date
        friend?.addToPets(pet)
        appDelegate.saveContext()
    }
    
    func updateViews(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateOfBirthLabel.text = dateFormatter.string(from: dateOfBirthPicker.date)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kindOfPetsArray.count
    }
    
    func pickerView(_ startNumPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        kindOfPetLabel.text = kindOfPetsArray[row]
    }
    
    func pickerView(_ startNumPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return kindOfPetsArray[row]
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "savePetUnwind" {
            if (petNameTextField.text == "") {
                return false
            }
        }
        return true
    }
    
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
