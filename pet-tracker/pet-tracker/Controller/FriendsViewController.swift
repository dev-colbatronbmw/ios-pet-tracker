//
//  FriendsViewController.swift
//  pet-tracker
//
//  Created by Colby Holmstead on 2/3/20.
//  Copyright © 2020 Colby Holmstead. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var friendSearch: UISearchBar!
    
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    var searchedFriends:[Friend] = []
    var searching = false
    var friend: Friend?
    
    var friends: [Friend] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.friends = retrieveFriends()
        friendSearch.delegate = self
        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
    }
    
    
    
    
    @IBAction func unwindToFriends(unwindSegue: UIStoryboardSegue){
        friends = retrieveFriends()
        self.friendsCollectionView.reloadData()
        print("unwind happened")
    }
    
    
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

extension FriendsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching{
            return  searchedFriends.count
        }else{
            return friends.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // edit the searching here
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendCell", for: indexPath) as! FriendCollectionViewCell
        if searching{
            cell.setup(friend: searchedFriends[indexPath.item])
        }else{
            
            cell.setup(friend: friends[indexPath.item])
        }
        
        
        return cell
        
        //and here
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        friend = friends[indexPath.item]
        performSegue(withIdentifier: "toPets", sender: Any?.self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPets"{
            if let petsViewController = segue.destination as? PetsViewController{
                petsViewController.friend = friend      
            }
        }
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
    
    
    
    
}
extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
          
          searchedFriends = friends.filter({ (item) -> Bool in
            let searchedText: NSString = item.lastName! as NSString
              
            return (searchedText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
          })
          searchedFriends = friends.filter({ (item) -> Bool in
                     let searchedText: NSString = item.firstName! as NSString
                       
                     return (searchedText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                   })
   
        
//        friends.forEach{ friend in
//            if(friend.lastName!.capitalized.contains(searchText.capitalized) || friend.firstName!.capitalized.contains(searchText.capitalized)
//                ){
//                searchedFriends.append(friend)
//            }
//        }
        searching = true
        self.friendsCollectionView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchedFriends = []
        self.friendsCollectionView.reloadData()
    }
    
}
