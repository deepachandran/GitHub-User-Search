//
//  ViewController.swift
//  GitSearchTest
//
//  Created by Deepa & Aneesh on 4/1/20.
//  Copyright © 2020 Deepa Chandran. All rights reserved.
//

import UIKit
import Alamofire


class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    
    
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    //var dataSource = Array<User>()
   
    
    
    //var user: User!
    var searchResponses = [SearchResponse]()
   var users = [User]()
     var searching = false
   //{
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    var filteredUsers = [User]()
    var userCell = [UserCell]()
    var selectedUserDetail = UserDetails()
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        userSearchBar.delegate = self
       
        //dataSource.removeAll()
        
       self.tableView.reloadData()
        //userlist = userlist()
        
    
        //self.downloadData ()
        
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userName = userSearchBar.text else {return}
        SearchResult.sharedInstance.userName = userName
        self.downloadData{
            SearchResult.sharedInstance.userName = userName
self.tableView.reloadData()
            self.tableView.isHidden = false
    }
     
        self.view.endEditing(true)
    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredUsers = users.filter({$0._name.prefix(searchText.count) == searchText})
//                searching = true
//        self.tableView.reloadData()
//
//
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  print(dataSource.count)
       if searching {
            return filteredUsers.count
        }
        else {
        return users.count
        
    }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print()
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = self.tableView.cellForRow(at: indexPath!) as! UserCell
        //print("cell name", currentCell.userName.text!)
        performSegue(withIdentifier: "SecondVcSegue", sender: currentCell.userName.text!)

                                            
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell {
            if searching {
                    let searchUserDetails = filteredUsers[indexPath.row]
                    cell.configureCell(user: searchUserDetails)
                }
                else {
                     let userDetails = users[indexPath.row]
                cell.configureCell(user: userDetails)
            }
            return cell
                   }
//        setting cell detail from user class
//       let userdetails = users[indexPath.row]
//           cell.configureCell(user: userdetails)
//
//               return cell
//         }
        else {
            return UserCell()
        }
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SecondVcSegue" {
            
        let destVc = segue.destination as! UserViewController
        destVc.name = sender as? String
        print("dest", destVc.name as Any)
           
    }
    }
    //Downloading searched user data for TableView
    func downloadData(completed: @escaping DownloadComplete) {
        let UserAPIurl = "https://api.github.com/search/users?q=\(SearchResult.sharedInstance.userName.replacingOccurrences(of: " ", with: "+"))"
    AF.request(UserAPIurl).responseJSON { response in
       // print(response)
        
            if let dict = response.value as? Dictionary<String, AnyObject> {

                if let list = dict["items"] as? [Dictionary<String, AnyObject>] {
                    let searchObj = SearchResponse()
                    let defaultUserArray: Array<User> = Array()
                    for obj in list {
                        let userObj = User()
                        userObj._name = (obj["login"] as? String)
                        userObj._avatarUrl = (obj["avatar_url"] as? String)

                        if (searchObj.items == nil){
                            let newUserArray: Array<User> = Array()
                            searchObj.items = newUserArray
                        }
                        searchObj.items?.append(userObj)
                        //print("test abc", obj)

                    }
                    self.users = searchObj.items ?? defaultUserArray
                    //print("forcast is", forecast.items!)


                 self.tableView.reloadData()
                }
            }
            completed()
           
        }

}
}

