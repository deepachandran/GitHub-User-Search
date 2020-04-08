//
//  SearchResult.swift
//  GitSearchTest
//
//  Created by Deepa & Aneesh on 4/2/20.
//  Copyright © 2020 Deepa Chandran. All rights reserved.
//

import Foundation

class SearchResult {
    static var sharedInstance = SearchResult()
    private init() {}
    
    var userName: String!
    
}
