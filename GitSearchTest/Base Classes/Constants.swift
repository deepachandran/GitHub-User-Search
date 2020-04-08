//
//  File.swift
//  GitSearchTest
//
//  Created by Deepa & Aneesh on 4/1/20.
//  Copyright © 2020 Deepa Chandran. All rights reserved.
//

import Foundation
import Alamofire
//class Service {
//    var searchResponses = [SearchResponse]()
//    var users = [User]()
//static let shared = Service()
typealias DownloadComplete = () -> ()
//func getResults(description: String, completed: @escaping (Result<[SearchResponse], ErrorMessage>) -> Void) {
////\(description.replacingOccurrences(of: " ", with: "+"))
let USERurl = "https://api.github.com/search/users?q=\(SearchResult.sharedInstance.userName.replacingOccurrences(of: " ", with: "+"))"


//}
