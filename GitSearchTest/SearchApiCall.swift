//
//  SearchApiCall.swift
//  GitSearchTest
//
//  Created by Deepa & Aneesh on 4/6/20.
//  Copyright © 2020 Deepa Chandran. All rights reserved.
//

import Foundation
import Alamofire

//var userArray = [User]()
//enum ResponceError:Error {
//    case noDataAvailable
//    case canNotProcessData
//}
//struct SearchRequest {
//    let resourceUrl:URL
//    
//    init(serachName:String) {
//        let resourceString = "https://api.github.com/search/users?q=\(serachName)"
//        guard let resourceURl = URL(string: resourceString) else {fatalError()}
//        
//        self.resourceUrl = resourceURl
//    }
//
//func downloadData(completed: @escaping (Result<[SearchResponse],ResponceError>)->void) {
//    
//    //let forecastUrl = URL(string: FORECAST_URL)
//    AF.request(resourceUrl).responseJSON { response in
//        print(response)
//    
//            if let dict = response.value as? Dictionary<String, AnyObject> {
//
//                if let list = dict["items"] as? [Dictionary<String, AnyObject>] {
//                    let forecast = SearchResponse()
//                    let defaultUserArray: Array<User> = Array()
//                    for obj in list {
//                        let userObj = User()
//                        userObj._name = (obj["login"] as? String)
//                        userObj._avatarUrl = (obj["avatar_url"] as? String)
//
//                        if (forecast.items == nil){
//                            let newUserArray: Array<User> = Array()
//                            forecast.items = newUserArray
//                        }
//                        forecast.items?.append(userObj)
//                        //print("test abc", obj)
//
//
//                    }
//                    self. = forecast.items ?? defaultUserArray
//                    //print("forcast is", forecast.items!)
//
//
//                    self.tableView.reloadData()
//                }
//            }
//            completed()
//           
//        }
//
//
//
//}
//}
