//
//  UserViewController.swift
//  GitSearchTest
//
//  Created by Deepa & Aneesh on 4/2/20.
//  Copyright © 2020 Deepa Chandran. All rights reserved.
//

import UIKit
import Alamofire

class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UsereNameLbl: UILabel!
    @IBOutlet weak var EmailLbl: UILabel!
    @IBOutlet weak var LocationLbl: UILabel!
    @IBOutlet weak var JoinDateLbl: UILabel!
    @IBOutlet weak var FollowerLbl: UILabel!
    @IBOutlet weak var FollowingLbl: UILabel!
    @IBOutlet weak var BioTextView: UITextView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var name: String!
    var repos = [repo]()
    var repoArray:Array<repo> = Array()
    var searchRepo = [repo]()
    var searching = false
    
    
   
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        SearchBar.delegate = self
        self.setUI()
        self.repoCall()
        self.tableview.reloadData()
        }
    
    func repoCall (){
        
        let repoURL = "https://api.github.com/users/\(name!)/repos"
        AF.request(repoURL).responseJSON { response in
            if let array = response.value as? NSArray {
                let defaultUserArray: Array<repo> = Array()
                let forecast = repositerySearchResponce()
                forecast.repos = Array<repo>()
                for obj in array {
                    if let dict = obj as? NSDictionary {
                        let repoObj = repo()
                        // Now reference the data you need using:
                        //let id = dict.value(forKey: "description")
                        repoObj.repoName =  dict.value(forKey: "name") as? String ?? "default value"
                        repoObj.numberOfForks =  dict.value(forKey: "forks") as? Int
                        repoObj.numberOfStars =  dict.value(forKey: "stargazers_count") as? Int
                        repoObj.repoUrl = dict.value(forKey: "html_url") as? String
                        
                        
                        //print("id is", repoObj.repoName!)
                        forecast.repos?.append(repoObj)
                        print("repo object added ", forecast.repos!.count)
                        
                    }
                    
                    
                   
//                    if (forecast.repos == nil){
//                        let newUserArray: Array<User> = Array()
//                        forecast.repos = newUserArray
//                    }
                    
                }
                
                self.repos = forecast.repos ?? defaultUserArray
                print("count", self.repos.count)
                 self.tableview.reloadData()
                
            }

        }
    }
    //parsing user data
    func setUI(){
        let userObj = UserDetails()

        let userURl = "https://api.github.com/users/\(name!)"
        
        AF.request(userURl).responseJSON { response in
            //print(response)
                if let dict = response.value as? Dictionary<String, AnyObject> {

                        
                            userObj._userName = (dict["name"] as? String)
                            userObj._email = (dict["email"] as? String)
                            userObj._joinDate = (dict["created_at"] as? String)
                            userObj._follower = (dict["followers"] as? Int)
                            userObj._following = (dict["following"] as? Int)
                            userObj._avatarImageUrl = (dict["avatar_url"] as? String)
                            userObj._location = (dict["location"] as? String)
                            userObj._bio = (dict["bio"] as? String)
                    if userObj._userName == nil {
                        self.UsereNameLbl.text = "User Name"
                    }
                    else{
                        self.UsereNameLbl.text = userObj._userName.capitalized
                    }
                    if userObj._email == nil {
                        self.EmailLbl.text = "Email: nil"
                    }
                    else{
                        self.EmailLbl.text = "Email: \(userObj._email ?? "Not available")"
                    }
                    if userObj._location == nil {
                        self.LocationLbl.text = "Location: nil"
                    }
                    else{
                        self.LocationLbl.text = "Location:\(userObj._location ?? "Not available")"
                    }
                    if userObj._follower == nil {
                       self.FollowerLbl.text = "No followers"
                    }
                    else{
                        self.FollowerLbl.text = "Followers:\(String(userObj._follower))"
                    }
                    if userObj._following == nil {
                       self.FollowingLbl.text = "No following"
                    }
                    else{
                        self.FollowingLbl.text = "Following:\(String(userObj._following))"
                    }
                    if userObj._bio == nil {
                       self.BioTextView.text = "No Bio"
                    }
                    else{
                        self.BioTextView.text = userObj._bio
                    }
                    
                   
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let date = dateFormatter.date(from:userObj._joinDate)
                    dateFormatter.locale = Locale(identifier: "en_US")
                    dateFormatter.dateStyle = .short
                    if userObj._joinDate == nil {
                       self.JoinDateLbl.text = "Join Date: nil"
                    }
                    else{
                        self.JoinDateLbl.text = "Join Date: \(dateFormatter.string(from: date!))"
                    }
                    
                    
                   
                    let url = URL(string: userObj._avatarImageUrl)
                        if let data = try? Data(contentsOf: url!)
                        {
                            let image: UIImage = UIImage(data: data)!
                            self.UserImage.image = image
                        }
                
                    }

                }

        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let urlString = repos.[indexPath.row]
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = self.tableview.cellForRow(at: indexPath!) as! RepoTableViewCell
        let urlString = currentCell.url
        if let url = URL(string: urlString)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("repo count", repos.count)
    if searching {
        return searchRepo.count
    }
    else {
    return repos.count
    }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "repoTableviewCell", for: indexPath) as? RepoTableViewCell {
           
            
            if searching {
                let searchRepoDetails = searchRepo[indexPath.row]
                cell.configureCell(repo: searchRepoDetails)
            }
            else {
                 let repoDetails = repos[indexPath.row]
            cell.configureCell(repo: repoDetails)
        }
            return cell
        }
        else {
        return RepoTableViewCell()
        }
}
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchRepo = repos.filter({(repo)-> Bool in
//            return repo.repoName.uppercased().contains(searchText)
//        })
            searchRepo = repos.filter({$0.repoName.prefix(searchText.count) == searchText})
            searching = true
            self.tableview.reloadData()
      
        

       
           
    

}
}
