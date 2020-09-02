//
//  PetsViewController.swift
//  pet-tracker
//
//  Created by Colby Holmstead on 2/14/20.
//  Copyright © 2020 Colby Holmstead. All rights reserved.
//

import UIKit

class PetsViewController: UIViewController {
    
    @IBOutlet weak var petsCollectionView: UICollectionView!
    var pets:[Pet] = []
    var friend: Friend?
    var friends:[Friend] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        friends = retrieveFriends()
        self.pets = friend?.pets?.allObjects as! [Pet]
        print(friend!.pets!.count)
        print(friend!.firstName!)
        petsCollectionView.dataSource = self
        petsCollectionView.delegate = self

    }
    func retrieveFriends() -> [Friend]{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("No AppDelegate Access!")
        }
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            return try context.fetch(Friend.fetchRequest())
        }catch let err as NSError{
            fatalError("Unable to Fetch people \(err.description)")
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let navigationController = segue.destination as! UINavigationController;
          let addPetTableViewController = navigationController.topViewController as! AddPetTableViewController;
          addPetTableViewController.friend = friend;
          }
}

extension PetsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend!.pets!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "petCell", for: indexPath) as! PetsCollectionViewCell
        pets = friend?.pets?.allObjects as! [Pet]
        cell.setup(pet: pets[indexPath.item])
        return cell
    }
  
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let collectionViewWidth = collectionView.bounds.width
          let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
          let spacingBetweenCells = flowLayout.minimumInteritemSpacing
          let adjustedCollectionViewWidth = collectionViewWidth - spacingBetweenCells
          let width: CGFloat = adjustedCollectionViewWidth - 20
          let height: CGFloat = adjustedCollectionViewWidth * 3/5
          return CGSize(width: width, height: height)
      }
    
    
      @IBAction func unwindToPets(unwindSegue: UIStoryboardSegue){
               petsCollectionView.reloadData()
           }
    
}
